(fn config []
  (let [wk (require :which-key)]
    (wk.setup {:preset :modern
               :filter (fn [mapping]
                         (and mapping.desc (not= mapping.desc "")))})
    (wk.add [;; File & Search operations
             {1 :<leader>f :group "󰈞 Find"}
             {1 :<leader>ff :desc "Find Files"}
             {1 :<leader>fg :desc "Live Grep"}
             {1 :<leader>fb :desc "Find Buffers"}
             {1 :<leader>fh :desc "Find Help"}
             {1 :<leader>fn :desc "New File"}
             {1 :<leader>g :group "󰊢 Git"}
             {1 :<leader>go :desc "Choose Ours"}
             {1 :<leader>gt :desc "Choose Theirs"}
             {1 :<leader>gb :desc "Choose Both"}
             {1 :<leader>gn :desc "Choose None"}
             {1 :<leader>gj :desc "Next Conflict"}
             {1 :<leader>gk :desc "Prev Conflict"}
             {1 :<leader>gp :desc "Preview Hunk"}
             {1 :<leader>gd :desc "Diff View"}
             {1 :<leader>gD :desc "Diff vs Last Commit"}
             {1 :<leader>gf :desc "File History (current)"}
             {1 :<leader>gF :desc "File History (all)"}
             ;; ECA 
             {1 :<leader>e :group "󰚩 ECA"}
             {1 :<leader>ec :desc "Open Chat"}
             {1 :<leader>ef :desc "Focus Sidebar"}
             {1 :<leader>et :desc "Toggle Sidebar"}
             {1 :<leader>ea :desc "Add File/Selection"}
             {1 :<leader>eA :desc "Pick File to Add"}
             ;; LSP
             {1 :<leader>l :group "󰿘 LSP"}
             {1 :<leader>lr :desc :Rename}
             {1 :<leader>lf :desc :Format}
             {1 :<leader>c :group "󰅱 Code"}
             {1 :<leader>ca :desc "Code Action"}
             ;; Panel/Window management
             {1 :<leader>p :group "󰽉 Panel"}
             {1 :<leader>pn :desc "New Vertical"}
             {1 :<leader>ph :desc "New Horizontal"}
             {1 :<leader>prl :desc "Resize Right"}
             {1 :<leader>prh :desc "Resize Left"}
             {1 :<leader>prk :desc "Resize Up"}
             {1 :<leader>prj :desc "Resize Down"}
             ;; File explorer
             {1 :<leader>m :desc "󰙅 Toggle Neo-tree"}
             ;; Search and replace
             {1 :<leader>s :desc "󰛔 Replace Word"}
             ;; Vim operations
             {1 :<leader>v :desc "󰕷 Goto Definition (Split)"}
             ;; Format
             {1 :<leader>F :desc "󰉤 Format Buffer"}
             ;; Visual mode specific
             {1 :<leader>h :group "Git Hunk" :mode :v}])
    (vim.api.nvim_create_autocmd :FileType
                                 {:pattern [:clojure :fennel :scheme]
                                  :callback (fn []
                                              (wk.add [{1 :<localleader>p
                                                        :group "󱗘 Paredit"}
                                                       {1 :<localleader>ps
                                                        :desc "Slurp forwards"}
                                                       {1 :<localleader>pS
                                                        :desc "Slurp backwards"}
                                                       {1 :<localleader>pb
                                                        :desc "Barf forwards"}
                                                       {1 :<localleader>pB
                                                        :desc "Barf backwards"}
                                                       {1 :<localleader>pf
                                                        :desc "Select current form"}
                                                       {1 :<localleader>pF
                                                        :desc "Select form content"}
                                                       {1 :<localleader>n
                                                        :desc "New empty form ()"}
                                                       {1 :<localleader>pw
                                                        :desc "Wrap symbol with ()"}
                                                       {1 :<localleader>pW
                                                        :desc "Wrap form with ()"}
                                                       {1 :<localleader>r
                                                        :group " REPL"}
                                                       {1 :<localleader>rp
                                                        :desc "Restart REPL"}
                                                       {1 :<localleader>mr
                                                        :desc "REPL Picker"}]))})))

{1 :folke/which-key.nvim :event :VimEnter : config}
