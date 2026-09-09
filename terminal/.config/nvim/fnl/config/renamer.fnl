(fn rename-window-opts [word]
  {:height 1
   :style :minimal
   :border :single
   :row 1
   :col 1
   :relative :cursor
   :width (+ (length word) 15)
   :title [[" Renamer " (.. "@" :comment.danger)]]
   :title_pos :center})

(fn create-rename-buf []
  (vim.api.nvim_create_buf false true))

(fn open-rename-win [buf opts]
  (let [win (vim.api.nvim_open_win buf true opts)]
    (tset (. vim.wo win) :winhl "Normal:Normal,FloatBorder:Removed")
    (vim.api.nvim_set_current_win win)
    win))

(fn seed-buf-content [buf word]
  (vim.api.nvim_buf_set_lines buf 0 -1 true [(.. " " word)]))

(fn start-prompt [buf]
  (tset (. vim.bo buf) :buftype :prompt)
  (vim.fn.prompt_setprompt buf "")
  (vim.api.nvim_input :A))

(fn bind-escape [buf]
  (vim.keymap.set [:i :n] :<Esc> :<cmd>q!<CR> {:buffer buf}))

(fn request-rename [client params]
  (client:request :textDocument/rename params nil 0))

(fn lsp-rename [new-name]
  (let [params (vim.lsp.util.make_position_params 0 nil)]
    (set params.newName new-name)
    (let [clients (vim.lsp.get_clients {:bufnr 0 :method :textDocument/rename})]
      (each [_ client (ipairs clients)]
        (request-rename client params)))))

(fn valid-rename? [new-name word]
  (and (> (length new-name) 0) (not= new-name word)))

(fn submit-rename [buf word text]
  (let [new-name (vim.trim text)]
    (vim.api.nvim_buf_delete buf {:force true})
    (when (valid-rename? new-name word)
      (lsp-rename new-name))))

(fn renamer []
  (let [word (vim.fn.expand :<cword>)
        buf (create-rename-buf)
        opts (rename-window-opts word)]
    (open-rename-win buf opts)
    (seed-buf-content buf word)
    (start-prompt buf)
    (bind-escape buf)
    (vim.fn.prompt_setcallback buf (fn [text] (submit-rename buf word text)))))

renamer
