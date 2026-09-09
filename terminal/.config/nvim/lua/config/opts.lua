-- [nfnl] fnl/config/opts.fnl
vim.opt.list = true
vim.opt.listchars = {tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163"}
vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.o.autoread = true
vim.wo.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = {"shift:2", "sbr"}
vim.opt.showbreak = "\226\134\179 "
vim.opt.sidescrolloff = 8
vim.opt.display:append("lastline")
vim.cmd("set number")
vim.cmd("set colorcolumn=80,120")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set laststatus=2")
vim.g.python3_host_prog = "/Users/tamer.cuba/.pyenv/shims/python3"
vim.g.transparent_background = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.backspace = {"start", "eol", "indent"}
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 80
return vim.diagnostic.config({virtual_text = {prefix = "\226\151\143", source = "always"}, signs = true, underline = true, severity_sort = true, float = {source = "always"}, update_in_insert = false})
