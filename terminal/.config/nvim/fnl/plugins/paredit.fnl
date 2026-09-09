(local paredit-filetypes [:clojure :fennel :scheme :risp])

(fn select-current-form [] (vim.cmd "normal! va("))
(fn select-form-content [] (vim.cmd "normal! vi("))
(fn new-empty-form []
  (let [[row col] (vim.api.nvim_win_get_cursor 0)
        line (vim.api.nvim_get_current_line)
        before (line:sub 1 col)
        after (line:sub (+ col 1))]
    (vim.api.nvim_set_current_line (.. before "()" after))
    (vim.api.nvim_win_set_cursor 0 [row col])))

(fn wrap-current-symbol [] (vim.cmd "normal! ysiw("))
(fn wrap-current-form []
  (vim.cmd "normal! va(")
  (-> (vim.api.nvim_replace_termcodes "S(" true false true)
      (vim.api.nvim_feedkeys :x false)))

(fn paredit-config []
  (let [paredit (require :nvim-paredit)]
    (paredit.setup {:filetypes paredit-filetypes
                    :keys {:<localleader>ps [paredit.api.slurp_forwards
                                             "Slurp forwards"]
                           :<localleader>pS [paredit.api.slurp_backwards
                                             "Slurp backwards"]
                           :<localleader>pb [paredit.api.barf_forwards
                                             "Barf forwards"]
                           :<localleader>pB [paredit.api.barf_backwards
                                             "Barf backwards"]
                           :<localleader>pf [select-current-form
                                             "Select current form"]
                           :<localleader>pF [select-form-content
                                             "Select form content"]
                           :<localleader>n [new-empty-form "New empty form"]
                           :<localleader>pw [wrap-current-symbol
                                             "Wrap current symbol with ()"]
                           :<localleader>pW [wrap-current-form
                                             "Wrap current form with ()"]}})))

(fn surround-config []
  (let [surround (require :nvim-surround)]
    (surround.setup)))

[{1 :julienvincent/nvim-paredit :ft paredit-filetypes :config paredit-config}
 {1 :kylechui/nvim-surround :config surround-config}
 {1 :windwp/nvim-autopairs :event :InsertEnter :opts {}}]
