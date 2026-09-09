(fn diff_buf_win_enter []
  (set vim.opt_local.foldenable false)
  (vim.opt_local.fillchars:append "diff: "))

(fn config []
  (let [actions (require :diffview.actions)
        diffview (require :diffview)]
    (-> {:file_panel {:listing_style :list}
         :keymaps {:view [[:n
                           :q
                           :<cmd>DiffviewClose<cr>
                           {:desc "Close Diffview"}]
                          [:n
                           "]f"
                           actions.select_next_entry
                           {:desc "Next file"}]
                          [:n
                           "[f"
                           actions.select_prev_entry
                           {:desc "Previous file"}]
                          [:n
                           :<leader>go
                           (actions.conflict_choose :ours)
                           {:desc "Choose Ours"}]
                          [:n
                           :<leader>gt
                           (actions.conflict_choose :theirs)
                           {:desc "Choose Theirs"}]
                          [:n
                           :<leader>gb
                           (actions.conflict_choose :both)
                           {:desc "Choose Both"}]
                          [:n
                           :<leader>gn
                           (actions.conflict_choose :none)
                           {:desc "Choose None"}]
                          [:n
                           :<leader>gj
                           actions.next_conflict
                           {:desc "Next Conflict"}]
                          [:n
                           :<leader>gk
                           actions.prev_conflict
                           {:desc "Prev Conflict"}]]
                   :file_panel [[:n
                                 :q
                                 :<cmd>DiffviewClose<cr>
                                 {:desc "Close Diffview"}]
                                [:n
                                 "]f"
                                 actions.select_next_entry
                                 {:desc "Next file"}]
                                [:n
                                 "[f"
                                 actions.select_prev_entry
                                 {:desc "Previous file"}]]
                   :file_history_panel [[:n
                                         :q
                                         :<cmd>DiffviewClose<cr>
                                         {:desc "Close Diffview"}]]}
         :hooks {: diff_buf_win_enter}}
        (diffview.setup))))

{1 :dlyongemallo/diffview.nvim
 :cmd [:DiffviewOpen :DiffviewFileHistory]
 :keys [{1 :<leader>gd 2 :<cmd>DiffviewOpen<cr> :desc "[G]it [D]iff View"}
        {1 :<leader>gD
         2 "<cmd>DiffviewOpen HEAD~1<cr>"
         :desc "[G]it [D]iff vs Last Commit"}
        {1 :<leader>gf
         2 "<cmd>DiffviewFileHistory %<cr>"
         :desc "[G]it [F]ile History (current)"}
        {1 :<leader>gF
         2 :<cmd>DiffviewFileHistory<cr>
         :desc "[G]it [F]ile History (all)"}]
 : config}
