-- [nfnl] fnl/after/ftplugin/fennel.fnl
vim.bo.lisp = true
vim.bo.autoindent = true
vim.opt_local.lispwords:append("fn,lambda,local,let,each,for,when,collect,icollect,accumulate")
return vim.keymap.set("i", "<C-n>", "()<Left>", {buffer = true, noremap = true})
