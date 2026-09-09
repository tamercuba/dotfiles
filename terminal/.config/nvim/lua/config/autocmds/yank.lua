-- [nfnl] fnl/config/autocmds/yank.fnl
local function highlight_yank()
  return vim.hl.on_yank()
end
return vim.api.nvim_create_autocmd("TextYankPost", {desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}), callback = highlight_yank})
