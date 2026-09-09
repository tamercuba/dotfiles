(fn selected-file-to-context [picker item]
  (picker:close)
  (if item
      (let [path (Snacks.picker.util.path item)]
        (if path
            (vim.cmd (.. :EcaChatAddFile " " (vim.fn.fnameescape path)))))))

(fn find-and-add []
  (let [snacks-picker Snacks.picker]
    (-> {:title "Add file to ECA chat" :confirm selected-file-to-context}
        (snacks-picker.files))))

{1 :editor-code-assistant/eca-nvim
 :dir (vim.fn.expand "~/projects/eca-nvim")
 :dependencies [:MunifTanjim/nui.nvim
                :nvim-lua/plenary.nvim
                :folke/snacks.nvim]
 :keys [{1 :<leader>ec 2 :<cmd>EcaChat<cr> :desc "Open ECA chat"}
        {1 :<leader>ef 2 :<cmd>EcaFocus<cr> :desc "Focus ECA sidebar"}
        {1 :<leader>et 2 :<cmd>EcaToggle<cr> :desc "Toggle ECA sidebar"}
        {1 :<leader>ea
         2 :<cmd>EcaChatAddFile<cr>
         :desc "Add current file to ECA chat"}
        {1 :<leader>eb
         2 :<cmd>EcaChatSelectBehavior<cr>
         :desc "Select ECA chat behavior"}
        {1 :<leader>em
         2 :<cmd>EcaChatSelectModel<cr>
         :desc "Select ECA chat model"}
        {1 :<leader>es 2 :<cmd>EcaStopResponse<cr> :desc "Stop ECA response"}
        {1 :<leader>en 2 :<cmd>EcaChatClear<cr> :desc "Clear ECA chat"}
        {1 :<leader>er 2 :<cmd>EcaServerRestart<cr> :desc "Restart ECA server"}
        {1 :<leader>el
         2 :<cmd>EcaChatListContexts<cr>
         :desc "List ECA chat contexts"}
        {1 :<leader>ek
         2 :<cmd>EcaChatClearContexts<cr>
         :desc "Clear ECA chat contexts"}
        {1 :<leader>ea
         2 :<cmd>EcaChatAddSelection<cr>
         :mode :x
         :desc "Add selection to ECA chat"}
        {1 :<leader>eA 2 find-and-add :desc "Pick file to add to ECA chat"}]
 :opts {:debug false
        :server_path ""
        :log {:level vim.log.levels.DEBUG}
        :behavior {:auto_set_keymaps true
                   :auto_focus_sidebar true
                   :auto_start_server true
                   :preserve_chat_history true}
        :windows {:edit {:start_insert false}}}}
