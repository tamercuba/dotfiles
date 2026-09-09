(local trust-path (.. (vim.fn.stdpath :config) :/.nfnl.fnl))

(fn trust-nfnl-config []
  (vim.secure.trust {:action :allow :path trust-path}))

(trust-nfnl-config)

(vim.api.nvim_create_autocmd :BufWritePost
                             {:group (vim.api.nvim_create_augroup :nfnl-trust
                                                                  {:clear true})
                              :pattern :.nfnl.fnl
                              :callback trust-nfnl-config})
