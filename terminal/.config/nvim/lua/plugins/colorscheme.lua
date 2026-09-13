-- [nfnl] fnl/plugins/colorscheme.fnl
local function config(_, opts)
  local gm_label = "gruvbox-material"
  local gm = require(gm_label)
  local diff_bg = "#1d3520"
  gm.setup(opts)
  vim.cmd.colorscheme(gm_label)
  vim.api.nvim_set_hl(0, "NormalFloat", {bg = "#282828"})
  vim.api.nvim_set_hl(0, "FloatBorder", {fg = "#665c54", bg = "#282828"})
  for _0, group in ipairs({"DiffAdd", "DiffChange", "DiffText"}) do
    vim.api.nvim_set_hl(0, group, {bg = diff_bg})
  end
  return vim.api.nvim_set_hl(0, "DiffDelete", {bg = "#3d1a1a"})
end
return {"f4z3r/gruvbox-material.nvim", name = "gruvbox-material", priority = 1000, opts = {contrast = "hard", background = {transparent = true}}, config = config, lazy = false}
