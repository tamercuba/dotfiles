-- [nfnl] fnl/config/keymaps.fnl
local opts = {noremap = true, silent = true}
local function buf_not_saved_warning()
  return vim.notify("Este buffer n\195\163o est\195\161 associado a um arquivo salvo.", vim.log.levels.WARN)
end
local function create_empty_file(path)
  local uv = vim.loop
  local fd = uv.fs_open(path, "w", 420)
  if fd then
    uv.fs_close(fd)
    return true
  else
    vim.notify(("Erro ao criar o arquivo: " .. path), vim.log.levels.ERROR)
    return false
  end
end
local function open_file(path)
  return vim.cmd(("edit " .. vim.fn.fnameescape(path)))
end
local function create_and_open_file(dir, input)
  if (input and (input ~= "")) then
    local new_path = (dir .. "/" .. input)
    if create_empty_file(new_path) then
      return open_file(new_path)
    else
      return nil
    end
  else
    return nil
  end
end
local function new_file()
  local current_path = vim.api.nvim_buf_get_name(0)
  if (current_path == "") then
    return buf_not_saved_warning()
  else
    local current_dir = vim.fn.fnamemodify(current_path, ":h")
    local function _4_(input)
      return create_and_open_file(current_dir, input)
    end
    return vim.ui.input({prompt = "Nome do novo arquivo: ", completion = "file"}, _4_)
  end
end
local function resize(command, sign, amount)
  return vim.cmd((command .. " " .. sign .. amount))
end
local function resize_by(command, sign, step)
  return resize(command, sign, (step * vim.v.count1))
end
local function increase_window_width()
  return resize_by("vertical resize", "-", 5)
end
local function decrease_window_width()
  return resize_by("vertical resize", "+", 5)
end
local function increase_window_height()
  return resize_by("resize", "+", 3)
end
local function decrease_window_height()
  return resize_by("resize", "-", 3)
end
local function any_loclist_open_3f()
  local found = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    found = (found or (win.loclist == 1))
  end
  return found
end
local function toggle_diagnostics()
  if any_loclist_open_3f() then
    return vim.cmd("lclose")
  else
    return vim.diagnostic.setloclist()
  end
end
local function first_line()
  return (vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or "")
end
local function namespace_name(line)
  return line:match("^%s*%(ns%s+([%w%.%-]+)")
end
local function reload_namespace()
  local ns_name = namespace_name(first_line())
  if ns_name then
    return vim.cmd(("ConjureEval (require '" .. ns_name .. " :reload-all)"))
  else
    return vim.notify("Namespace n\195\163o encontrado na primeira linha", vim.log.levels.WARN)
  end
end
local function restart_repl()
  vim.fn.system("pkill -f lein")
  return vim.fn.jobstart("lein repl", {detach = true})
end
local function select_shadow_build()
  local function _8_(input)
    if (input and (input ~= "")) then
      return vim.cmd(("ConjureShadowSelect " .. input))
    else
      return nil
    end
  end
  return vim.ui.input({prompt = "Shadow-cljs build: "}, _8_)
end
local function highlight_yank()
  return vim.hl.on_yank()
end
local simple_keymaps = {{"n", "n", "nzzzv"}, {"n", "N", "Nzzzv"}, {"v", "<", "<gv", opts}, {"v", ">", ">gv", opts}, {"n", "x", "\"_x", opts}}
for _, _10_ in ipairs(simple_keymaps) do
  local mode = _10_[1]
  local lhs = _10_[2]
  local rhs = _10_[3]
  local kopts = _10_[4]
  vim.keymap.set(mode, lhs, rhs, kopts)
end
local window_nav_keymaps = {{"<c-l>", ":wincmd l<CR>", "Go to right table"}, {"<c-h>", ":wincmd h<CR>", "Go to left table"}, {"<c-j>", ":wincmd j<CR>", "Go to upper table"}, {"<c-k>", ":wincmd k<CR>", "Go to bottom table"}}
for _, _11_ in ipairs(window_nav_keymaps) do
  local lhs = _11_[1]
  local rhs = _11_[2]
  local desc = _11_[3]
  vim.keymap.set("n", lhs, rhs, {desc = desc})
end
vim.keymap.set("n", "<leader>fn", new_file, {desc = "[N]ew [F]ile", noremap = true, silent = true})
vim.keymap.set("n", "<leader>pn", ":vsplit<CR>", {desc = "New vertical panel", noremap = true, silent = true})
vim.keymap.set("n", "<leader>ph", ":split<CR>", {desc = "New horizontal panel", noremap = true, silent = true})
vim.keymap.set("n", "<Leader>prl", increase_window_width, {desc = "Increase window width"})
vim.keymap.set("n", "<Leader>prh", decrease_window_width, {desc = "Decrease window width"})
vim.keymap.set("n", "<Leader>prk", increase_window_height, {desc = "Increase window height"})
vim.keymap.set("n", "<Leader>prj", decrease_window_height, {desc = "Decrease window height"})
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", {noremap = true, silent = true})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "moves lines down in visual selection"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "moves lines up in visual selection"})
vim.keymap.set("n", "<leader>d", toggle_diagnostics, {desc = "Toggle diagnostics (buffer)"})
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {desc = "Replace word cursor is on globally", noremap = true, silent = false})
vim.api.nvim_create_autocmd("TextYankPost", {desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}), callback = highlight_yank})
vim.keymap.set("n", "<localleader>rn", reload_namespace, {desc = "Reload namespace and all deps", noremap = true, silent = true})
vim.keymap.set("n", "<localleader>rp", restart_repl, {desc = "Kill lein processes, start new REPL ", noremap = true, silent = true})
return vim.keymap.set("n", "<localleader>cj", select_shadow_build, {desc = "Select shadow-cljs build", noremap = true, silent = true})
