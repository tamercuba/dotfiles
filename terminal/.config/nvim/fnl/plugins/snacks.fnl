(local exclude [:node_modules
                :.git
                :*.lock
                :target
                :.clj-kondo
                :**/lua/**/*.lua])

(fn find-files []
  (Snacks.picker.files {:layout {:preset :vertical :hidden [:preview]}}))

(fn find-grep []
  (Snacks.picker.grep))

(fn find-buffers []
  (Snacks.picker.buffers))

(fn find-help []
  (Snacks.picker.help))

(fn find-reference [] (Snacks.picker.lsp_reference))

(fn find-diagnostics [] (Snacks.picker.diagnostics))

(fn find-git-status [] (Snacks.picker.git_status))

(fn find-lsp-implementation [] (Snacks.picker.lsp_implementation))

(fn find-git-unstaged [] (Snacks.picker.git_diff {:group true}))

{1 :folke/snacks.nvim
 :priority 1000
 :lazy false
 :opts {:picker {:ui_select true
                 :sources {:files {:hidden true : exclude}
                           :grep {:hidden true : exclude}}}}
 :keys [{1 :<leader>ff 2 find-files :desc "[F]ind [F]iles"}
        {1 :<leader>fg 2 find-grep :desc "[F]ind [G]rep"}
        {1 :<leader>fb 2 find-buffers :desc "[F]ind [B]uffers"}
        {1 :<leader>fh 2 find-help :desc "[F]ind [H]elp"}
        {1 :<leader>fr 2 find-reference :desc "[F]ind [R]eference"}
        {1 :<leader>fd 2 find-diagnostics :desc "[F]ind [D]iagnostics"}
        {1 :<leader>fs 2 find-git-status :desc "[F]ind git [S]tatus"}
        {1 :<leader>fi
         2 find-lsp-implementation
         :desc "[F]ind lsp [I]mplementation"}
        {1 :<leader>fu 2 find-git-unstaged :desc "[F]ind git [U]nstaged"}]}
