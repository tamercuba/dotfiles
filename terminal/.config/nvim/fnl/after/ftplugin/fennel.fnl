(set vim.bo.lisp true)
(set vim.bo.autoindent true)
(vim.opt_local.lispwords:append "fn,lambda,local,let,each,for,when,collect,icollect,accumulate")

(vim.keymap.set :i :<C-n> "()<Left>" {:buffer true :noremap true})
