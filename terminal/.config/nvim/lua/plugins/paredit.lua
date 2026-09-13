-- [nfnl] fnl/plugins/paredit.fnl
local paredit_filetypes = {"clojure", "fennel", "scheme", "risp"}
local function select_current_form()
  return vim.cmd("normal! va(")
end
local function select_form_content()
  return vim.cmd("normal! vi(")
end
local function new_empty_form()
  local _let_1_ = vim.api.nvim_win_get_cursor(0)
  local row = _let_1_[1]
  local col = _let_1_[2]
  local line = vim.api.nvim_get_current_line()
  local before = line:sub(1, col)
  local after = line:sub((col + 1))
  vim.api.nvim_set_current_line((before .. "()" .. after))
  return vim.api.nvim_win_set_cursor(0, {row, col})
end
local function wrap_current_symbol()
  return vim.cmd("normal! ysiw(")
end
local function wrap_current_form()
  vim.cmd("normal! va(")
  return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("S(", true, false, true), "x", false)
end
local function paredit_config()
  local paredit = require("nvim-paredit")
  return paredit.setup({filetypes = paredit_filetypes, keys = {["<localleader>ps"] = {paredit.api.slurp_forwards, "Slurp forwards"}, ["<localleader>pS"] = {paredit.api.slurp_backwards, "Slurp backwards"}, ["<localleader>pb"] = {paredit.api.barf_forwards, "Barf forwards"}, ["<localleader>pB"] = {paredit.api.barf_backwards, "Barf backwards"}, ["<localleader>pf"] = {select_current_form, "Select current form"}, ["<localleader>pF"] = {select_form_content, "Select form content"}, ["<localleader>n"] = {new_empty_form, "New empty form"}, ["<localleader>pw"] = {wrap_current_symbol, "Wrap current symbol with ()"}, ["<localleader>pW"] = {wrap_current_form, "Wrap current form with ()"}}})
end
local function surround_config()
  local surround = require("nvim-surround")
  return surround.setup()
end
return {{"julienvincent/nvim-paredit", ft = paredit_filetypes, config = paredit_config}, {"kylechui/nvim-surround", config = surround_config}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}}
