-- [nfnl] fnl/plugins/obsidian.fnl
local function config()
  local obsidian = require("obsidian")
  obsidian.setup({workspaces = {{name = "personal", path = "~/projects/obsidian-vault"}}, daily_notes = {folder = "Nubank/Diarios", date_format = "%d-%m-%y", default_tags = {"daily-notes"}, template = "Daily"}, templates = {folder = "Templates", date_format = "%d-%m-%y", time_format = "%H:%M"}, legacy_commands = false})
  return vim.keymap.set("n", "<leader>o", ":Obsidian<CR>", {desc = "[O]bsidian", silent = true})
end
return {"obsidian-nvim/obsidian.nvim", version = "*", event = {("BufReadPre" .. " " .. vim.fn.expand("~") .. "/projects/obsidian-vault/*.md"), ("BufNewFile" .. " " .. vim.fn.expand("~") .. "/projects/obsidian-vault/*.md")}, config = config}
