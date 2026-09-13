-- [nfnl] fnl/plugins/lualine.fnl
local function filename_with_path()
  local relpath = vim.fn.expand("%:.")
  local filename = vim.fn.expand("%:t")
  local dir = vim.fn.fnamemodify(relpath, ":h")
  if (dir == ".") then
    return filename
  else
    return (dir .. "/" .. filename)
  end
end
local function config()
  local ll = require("lualine")
  return ll.setup({options = {theme = "gruvbox-material"}, sections = {lualine_c = {filename_with_path}}})
end
return {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, config = config}
