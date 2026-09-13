-- [nfnl] fnl/config/renamer.fnl
local function rename_window_opts(word)
  return {height = 1, style = "minimal", border = "single", row = 1, col = 1, relative = "cursor", width = (#word + 15), title = {{" Renamer ", ("@" .. "comment.danger")}}, title_pos = "center"}
end
local function create_rename_buf()
  return vim.api.nvim_create_buf(false, true)
end
local function open_rename_win(buf, opts)
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.wo[win]["winhl"] = "Normal:Normal,FloatBorder:Removed"
  vim.api.nvim_set_current_win(win)
  return win
end
local function seed_buf_content(buf, word)
  return vim.api.nvim_buf_set_lines(buf, 0, -1, true, {(" " .. word)})
end
local function start_prompt(buf)
  vim.bo[buf]["buftype"] = "prompt"
  vim.fn.prompt_setprompt(buf, "")
  return vim.api.nvim_input("A")
end
local function bind_escape(buf)
  return vim.keymap.set({"i", "n"}, "<Esc>", "<cmd>q!<CR>", {buffer = buf})
end
local function request_rename(client, params)
  return client:request("textDocument/rename", params, nil, 0)
end
local function lsp_rename(new_name)
  local params = vim.lsp.util.make_position_params(0, nil)
  params.newName = new_name
  local clients = vim.lsp.get_clients({bufnr = 0, method = "textDocument/rename"})
  for _, client in ipairs(clients) do
    request_rename(client, params)
  end
  return nil
end
local function valid_rename_3f(new_name, word)
  return ((#new_name > 0) and (new_name ~= word))
end
local function submit_rename(buf, word, text)
  local new_name = vim.trim(text)
  vim.api.nvim_buf_delete(buf, {force = true})
  if valid_rename_3f(new_name, word) then
    return lsp_rename(new_name)
  else
    return nil
  end
end
local function renamer()
  local word = vim.fn.expand("<cword>")
  local buf = create_rename_buf()
  local opts = rename_window_opts(word)
  open_rename_win(buf, opts)
  seed_buf_content(buf, word)
  start_prompt(buf)
  bind_escape(buf)
  local function _2_(text)
    return submit_rename(buf, word, text)
  end
  return vim.fn.prompt_setcallback(buf, _2_)
end
return renamer
