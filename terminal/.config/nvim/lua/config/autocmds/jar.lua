-- [nfnl] fnl/config/autocmds/jar.fnl
local function open_jar_entry(buf, jar, entry)
  local content = vim.fn.system({"unzip", "-p", jar, entry})
  if (vim.v.shell_error == 0) then
    local lines = vim.split(content, "\n", {trimempty = false})
    local bo = vim.bo[buf]
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    bo.modifiable = false
    bo.buftype = "nofile"
    bo.readonly = true
    local function _1_()
      return vim.cmd("filetype detect")
    end
    return vim.schedule(_1_)
  else
    return nil
  end
end
local function zipfile_jar_entry(name)
  local path = name:gsub("^zipfile://", "")
  return path:match("^(.-)::(.+)$")
end
local function open_zipfile(ev)
  local name = vim.api.nvim_buf_get_name(ev.buf)
  local jar, entry = zipfile_jar_entry(name)
  if (jar and entry) then
    return open_jar_entry(ev.buf, jar, entry)
  else
    return nil
  end
end
local function jarfile_jar_entry(name)
  return name:match("^jar:file://(.-)!/(.+)$")
end
local function open_jarfile(ev)
  local name = vim.api.nvim_buf_get_name(ev.buf)
  local jar, entry = jarfile_jar_entry(name)
  if (jar and entry) then
    return open_jar_entry(ev.buf, jar, entry)
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("BufReadCmd", {pattern = "zipfile://*", callback = open_zipfile})
return vim.api.nvim_create_autocmd("BufReadCmd", {pattern = "jar:file://*", callback = open_jarfile})
