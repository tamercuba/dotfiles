-- [nfnl] fnl/config/autocmds/clojure.fnl
local function new_clj_file_3f(buf)
  return (vim.api.nvim_buf_line_count(buf) <= 1)
end
local function project_root(dir)
  local marker = vim.fs.find({"deps.edn", "project.clj"}, {upward = true, path = dir, type = "file"})[1]
  if marker then
    return vim.fs.dirname(marker)
  else
    return nil
  end
end
local function relative_subpath(rel)
  return (rel:match("^src/clj[sc]?/(.+)") or rel:match("^test/clj[sc]?/(.+)") or rel:match("^src/(.+)") or rel:match("^test/(.+)"))
end
local function clj_namespace(root, file)
  local rel = file:sub((#root + 2))
  local subpath = relative_subpath(rel)
  if (subpath and subpath:match("%.clj$")) then
    local trimmed = subpath:gsub("%.clj$", "")
    local slashed = trimmed:gsub("/", ".")
    local dashed = slashed:gsub("_", "-")
    local ns = dashed:gsub("^%.*", "")
    if (ns ~= "") then
      return ns
    else
      return nil
    end
  else
    return nil
  end
end
local function empty_buffer_3f(buf)
  local existing = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
  return ((existing == nil) or (existing == ""))
end
local function write_namespace_21(buf, ns)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {("(ns " .. ns .. ")"), ""})
  return vim.api.nvim_buf_set_mark(buf, "n", 1, 1, {})
end
local function insert_clojure_ns_if_needed(args)
  local buf = args.buf
  local file = vim.api.nvim_buf_get_name(buf)
  if (new_clj_file_3f(buf) and (file ~= "")) then
    local root = project_root(vim.fs.dirname(file))
    if root then
      local ns = clj_namespace(root, file)
      if (ns and empty_buffer_3f(buf)) then
        return write_namespace_21(buf, ns)
      else
        return nil
      end
    else
      return nil
    end
  else
    return nil
  end
end
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {pattern = "*.clj", callback = insert_clojure_ns_if_needed})
local function trim_trailing_blank_lines()
  local total_lines = vim.api.nvim_buf_line_count(0)
  local last_nonblank = vim.fn.prevnonblank(total_lines)
  if (last_nonblank < (total_lines - 1)) then
    return vim.api.nvim_buf_set_lines(0, (last_nonblank + 1), total_lines, false, {})
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.clj", "*.cljs", "*.cljc", "*.edn"}, callback = trim_trailing_blank_lines})
vim.filetype.add({extension = {risp = "risp"}})
local function shebang_clojure_3f(_, bufnr)
  local first_line = (vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or "")
  if first_line:match("^#!/usr/bin/env bb") then
    return "clojure"
  else
    return nil
  end
end
vim.filetype.add({pattern = {[".*"] = shebang_clojure_3f}})
local function _9_()
  return vim.cmd("ConjureConnect")
end
vim.api.nvim_create_user_command("ConjureGo", _9_, {desc = "Conecta o Conjure ao REPL"})
local function resize_conjure_log()
  return vim.cmd(("vertical resize " .. math.floor((0.3 * vim.o.columns))))
end
return vim.api.nvim_create_autocmd("BufWinEnter", {pattern = {"conjure-log-*"}, callback = resize_conjure_log})
