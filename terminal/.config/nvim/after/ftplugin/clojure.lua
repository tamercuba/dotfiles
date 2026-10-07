vim.opt_local.iskeyword:remove("/")
vim.opt_local.iskeyword:remove(".")

vim.bo.lisp = true
vim.bo.autoindent = true
vim.opt_local.lispwords:append("s/defn,s/def,s/defschema,s/defrecord")

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = true, desc = "LSP: Go to definition" })
vim.keymap.set("i", "<C-n>", "()<Left>", { buffer = true, noremap = true })
