-- [nfnl] fnl/core/lazy.fnl
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
local uv = (vim.uv or vim.loop)
if not uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
  if (vim.v.shell_error ~= 0) then
    error(("Error cloning lazy.nvim:\n" .. out))
  else
  end
else
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")
return lazy.setup({import = "plugins"}, {install = {missing = true, colorscheme = {"habamax"}}, checker = {enabled = true, notify = false}, change_detection = {enabled = true, notify = false}, ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin"}}}})
