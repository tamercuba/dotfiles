(fn lsp-map [buf keys func desc]
  (vim.keymap.set :n keys func {:buffer buf :desc (.. "LSP: " desc)}))

(fn hover []
  (vim.lsp.buf.hover {:border :rounded}))

(fn signature-help []
  (vim.lsp.buf.signature_help {:border :rounded}))

(fn next-diagnostic []
  (vim.diagnostic.jump {:count 1 :float true}))

(fn prev-diagnostic []
  (vim.diagnostic.jump {:count -1 :float true}))

(fn lsp-keymap-specs []
  [[:gl vim.diagnostic.open_float "Open Diagnostic Float"]
   [:K hover "Hover Documentation"]
   [:gs signature-help "[S]ignature Documentation"]
   [:gd vim.lsp.buf.definition "[G]oto [D]efinition"]
   [:<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction"]
   [:<leader>lr vim.lsp.buf.rename "[R]ename all references"]
   [:<leader>lf vim.lsp.buf.format "[F]ormat"]
   [:<leader>v
    "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>"
    "Goto Definition in Vertical Split"]
   ["]d" next-diagnostic "Next Diagnostic"]
   ["[d" prev-diagnostic "Previous Diagnostic"]
   [:<leader>vr (require :config.renamer) "[R]ename buffer"]])

(fn bind-lsp-keymaps [buf]
  (each [_ [keys func desc] (ipairs (lsp-keymap-specs))]
    (lsp-map buf keys func desc)))

(fn clear-lsp-highlight [event]
  (vim.lsp.buf.clear_references)
  (vim.api.nvim_clear_autocmds {:group :lsp-highlight :buffer event.buf}))

(fn setup-document-highlight [buf]
  (let [highlight-augroup (vim.api.nvim_create_augroup :lsp-highlight
                                                       {:clear false})]
    (vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI]
                                 {:buffer buf
                                  :group highlight-augroup
                                  :callback vim.lsp.buf.document_highlight})
    (vim.api.nvim_create_autocmd [:CursorMoved :CursorMovedI]
                                 {:buffer buf
                                  :group highlight-augroup
                                  :callback vim.lsp.buf.clear_references})
    (vim.api.nvim_create_autocmd :LspDetach
                                 {:group (vim.api.nvim_create_augroup :lsp-detach
                                                                      {:clear true})
                                  :callback clear-lsp-highlight})))

(fn supports-document-highlight? [client buf]
  (and client (client:supports_method vim.lsp.protocol.Methods.textDocument_documentHighlight
                                      {:bufnr buf})))

(fn on-lsp-attach [event]
  (bind-lsp-keymaps event.buf)
  (let [client (vim.lsp.get_client_by_id event.data.client_id)]
    (when (supports-document-highlight? client event.buf)
      (setup-document-highlight event.buf))))

(vim.api.nvim_create_autocmd :LspAttach
                             {:group (vim.api.nvim_create_augroup :lsp-attach
                                                                  {:clear true})
                              :callback on-lsp-attach})
