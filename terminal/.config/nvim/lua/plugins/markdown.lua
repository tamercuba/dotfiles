-- [nfnl] fnl/plugins/markdown.fnl
local function build()
  local lazy = require("lazy")
  lazy.load({plugins = {"markdown-preview.nvim"}})
  return vim.fn["mkdp#util#install"]()
end
return {"iamcco/markdown-preview.nvim", cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"}, ft = "markdown", keys = {{"<leader>pm", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview"}}, build = build}
