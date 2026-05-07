vim.opt_local.iskeyword:remove("/")
vim.opt_local.iskeyword:remove(".")

vim.bo.lisp = true
vim.bo.autoindent = true
vim.opt_local.lispwords:append("s/defn,s/def,s/defschema,s/defrecord")

vim.keymap.set("i", "<C-n>", "()<Left>", { buffer = true, noremap = true })
