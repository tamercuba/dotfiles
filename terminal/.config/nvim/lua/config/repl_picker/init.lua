-- [nfnl] fnl/config/repl_picker/init.fnl
local function repl_config_dir()
  return (vim.fn.stdpath("config") .. "/lua/config/repl_picker")
end
local function repl_config_files()
  return vim.fn.glob((repl_config_dir() .. "/*.repl.lua"), false, true)
end
local function load_repl_file(path)
  local ok, result = pcall(dofile, path)
  if (ok and (type(result) == "table")) then
    return result
  else
    local basename = path:match("([^/]+)$")
    vim.notify(string.format("Failed to load REPL config from %s: %s", basename, tostring(result)), vim.log.levels.WARN)
    return {}
  end
end
local function load_repl_configurations()
  local merged = {}
  for _, path in ipairs(repl_config_files()) do
    merged = vim.tbl_deep_extend("force", merged, load_repl_file(path))
  end
  return merged
end
local function find_marker_upwards(marker, from)
  local found = vim.fn.findfile(marker, (from .. ";"))
  if (found ~= "") then
    return vim.fn.fnamemodify(found, ":p:h")
  else
    return nil
  end
end
local function find_project_root()
  local from = vim.fn.expand("%:p:h")
  local root = nil
  for _, marker in ipairs({"project.clj", "deps.edn", ".git"}) do
    root = (root or find_marker_upwards(marker, from))
  end
  return root
end
local function projects_dir()
  return os.getenv("PROJECTS")
end
local function strip_projects_dir(root, pdir)
  if pdir then
    local stripped = root:gsub(pdir, "")
    return stripped
  else
    return root
  end
end
local function prefix_match(repls, root)
  local found = nil
  for candidate, cfg in pairs(repls) do
    local or_4_ = found
    if not or_4_ then
      if root:find(candidate, 1, true) then
        or_4_ = cfg
      else
        or_4_ = nil
      end
    end
    found = or_4_
  end
  return found
end
local function project_repls_for(all_repls, root)
  if root then
    return (all_repls[root] or prefix_match(all_repls, root))
  else
    return nil
  end
end
local function current_project_repls(all_repls)
  local raw_root = find_project_root()
  local pdir = projects_dir()
  if raw_root then
    return project_repls_for(all_repls, strip_projects_dir(raw_root, pdir))
  else
    return nil
  end
end
local function default_repl_list(cwd)
  return {{display = "Babashka", config = {command = "bb-nrepl", cwd = cwd}}, {display = "REPL", config = {command = "lein repl", cwd = cwd}}}
end
local function repls_map__3elist(repls)
  local tbl_26_ = {}
  local i_27_ = 0
  for display, config in pairs(repls) do
    local val_28_ = {display = display, config = config}
    if (nil ~= val_28_) then
      i_27_ = (i_27_ + 1)
      tbl_26_[i_27_] = val_28_
    else
    end
  end
  return tbl_26_
end
local function sorted_by_display(list)
  local function _9_(a, b)
    return (a.display < b.display)
  end
  table.sort(list, _9_)
  return list
end
local function repl_list(all_repls, cwd)
  local case_10_ = current_project_repls(all_repls)
  if (case_10_ == nil) then
    return default_repl_list(cwd)
  elseif (nil ~= case_10_) then
    local repls = case_10_
    return sorted_by_display(repls_map__3elist(repls))
  else
    return nil
  end
end
local function picker_items(repls)
  local tbl_26_ = {}
  local i_27_ = 0
  for _, repl in ipairs(repls) do
    local val_28_ = {text = repl.display, repl = repl}
    if (nil ~= val_28_) then
      i_27_ = (i_27_ + 1)
      tbl_26_[i_27_] = val_28_
    else
    end
  end
  return tbl_26_
end
local function inside_tmux_3f()
  vim.fn.system("tmux display-message -p '#{session_name}' 2>/dev/null")
  return (vim.v.shell_error == 0)
end
local function ensure_repl_session_21()
  vim.fn.system("tmux has-session -t REPL 2>/dev/null")
  if (vim.v.shell_error ~= 0) then
    vim.fn.system("tmux new-session -d -s REPL")
    return vim.notify("Created tmux session: REPL", vim.log.levels.INFO)
  else
    return nil
  end
end
local function resolve_cwd(cwd, pdir)
  if (pdir and not cwd:match("^/")) then
    return (pdir .. cwd)
  else
    return cwd
  end
end
local function window_name(display)
  local name = display:gsub(" REPL$", "")
  return name
end
local function tmux_new_window_cmd(name, full_command)
  return string.format("tmux new-window -t %s -n %s '%s'", vim.fn.shellescape("REPL"), vim.fn.shellescape(name), full_command)
end
local function start_repl_in_tmux_21(display, config)
  if not inside_tmux_3f() then
    return vim.notify("You must be inside a tmux session to use this feature", vim.log.levels.ERROR)
  else
    ensure_repl_session_21()
    local cwd = resolve_cwd(config.cwd, projects_dir())
    local full_command = string.format("cd %s && %s", vim.fn.shellescape(cwd), config.command)
    vim.fn.system(tmux_new_window_cmd(window_name(display), full_command))
    if (vim.v.shell_error == 0) then
      return vim.notify(string.format("Started %s in tmux session 'REPL'", display), vim.log.levels.INFO)
    else
      return vim.notify(string.format("Failed to start %s", display), vim.log.levels.ERROR)
    end
  end
end
local function confirm_repl(picker, item)
  picker:close()
  if item then
    return start_repl_in_tmux_21(item.repl.display, item.repl.config)
  else
    return nil
  end
end
local function format_repl_item(item)
  return {{item.text}}
end
local function select_and_start_repl(all_repls)
  local has_snacks, snacks = pcall(require, "snacks")
  if not has_snacks then
    return vim.notify("snacks.nvim is not installed", vim.log.levels.ERROR)
  else
    return snacks.picker.pick({title = "REPL Picker", items = picker_items(repl_list(all_repls, (find_project_root() or vim.fn.getcwd()))), layout = {preset = "select"}, format = format_repl_item, confirm = confirm_repl})
  end
end
local all_repls = load_repl_configurations()
local function _19_()
  return select_and_start_repl(all_repls)
end
vim.api.nvim_create_user_command("ReplPicker", _19_, {desc = "Open REPL picker to start a REPL in tmux"})
local function _20_()
  return select_and_start_repl(all_repls)
end
return vim.keymap.set("n", "<localleader>mr", _20_, {desc = "Open REPL picker", noremap = true, silent = true})
