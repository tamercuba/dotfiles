-- [nfnl] fnl/plugins/gitsigns.fnl
local function config()
  do
    local gs = require("gitsigns")
    gs.setup({signs = {add = {text = "\226\148\131"}, change = {text = "\226\148\131"}, delete = {text = "_"}, topdelete = {text = "\226\128\190"}, changedelete = {text = "~"}, untracked = {text = "\226\148\134"}}, signcolumn = true, watch_gitdir = {follow_files = true}, auto_attach = true, current_line_blame = true, current_line_blame_opts = {virt_text = true, virt_text_pos = "eol", delay = 1000, virt_text_priority = 100, ignore_whitespace = false, relative_time = false}, current_line_blame_formatter = "<author> <author_time:%Y-%m-%d> - <summary>", sign_priority = 6, update_debounce = 100, status_formatter = nil, max_file_length = 40000, preview_config = {border = "single", style = "minimal", relative = "cursor", row = 0, col = 1}, attach_to_untracked = false, linehl = false, numhl = false, word_diff = false})
  end
  vim.keymap.set("n", "<leader>ghv", ":Gitsigns preview_hunk<CR>", {desc = "[G]it [H]unk [V]iew"})
  vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", {desc = "[G]it [H]unk [R]eset"})
  vim.keymap.set("n", "<leader>ghn", ":Gitsigns next_hunk<CR>", {desc = "[G]it [N]ext Hunk"})
  vim.keymap.set("n", "<leader>ghp", ":Gitsigns prev_hunk<CR>", {desc = "[G]it [P]revious Hunk"})
  return vim.keymap.set("n", "<leader>gha", ":Gitsigns stage_hunk<CR>", {desc = "[G]it [H]unk [A]dd"})
end
return {"lewis6991/gitsigns.nvim", version = "*", config = config}
