(fn non-empty [s fallback]
  (if (= s "") fallback s))

(fn flatten [lists]
  (let [result []]
    (each [_ lines (ipairs lists)]
      (each [_ line (ipairs lines)]
        (table.insert result line)))
    result))

(local capability-map
       [[:completionProvider :completion]
        [:hoverProvider :hover]
        [:definitionProvider :goto_definition]
        [:referencesProvider :find_references]
        [:documentFormattingProvider :formatting]
        [:renameProvider :rename]
        [:codeActionProvider :code_actions]])

(fn capability-labels [caps]
  (if caps
      (icollect [_ [key label] (ipairs capability-map)]
        (if (. caps key) label))
      []))

(fn attached-buffers-str [client]
  (table.concat (icollect [_ attached-buf (pairs client.attached_buffers)]
                  (tostring attached-buf)) ", "))

(fn other-buffer-client-line [client]
  (string.format "  - %s (id: %d, buffers: %s)" client.name client.id
                 (attached-buffers-str client)))

(fn no-clients-lines []
  (let [all-clients (vim.lsp.get_clients)]
    (if (> (length all-clients) 0)
        (flatten [["Available LSP clients (attached to other buffers):"]
                  (icollect [_ client (pairs all-clients)]
                    (other-buffer-client-line client))])
        ["No LSP clients running"])))

(fn client-filetypes-str [client]
  (if client.config.filetypes
      (table.concat client.config.filetypes ", ")
      "Not specified"))

(fn client-capabilities-line [client]
  (let [labels (capability-labels client.server_capabilities)]
    (if (> (length labels) 0)
        [(.. "  - capabilities: " (table.concat labels ", "))]
        [])))

(fn client-lines [i client]
  (flatten [[(string.format "Client %d: %s" i client.name)
             (.. "  - id: " client.id)
             (.. "  - root directory: " (or client.config.root_dir "Not set"))
             (.. "  - filetypes: " (client-filetypes-str client))]
            (client-capabilities-line client)
            [(.. "  - attached buffers: " (attached-buffers-str client))]
            (if (= i 1) [(.. "  - log file: " (vim.lsp.get_log_path))] [])
            [""]]))

(fn active-clients-lines [clients]
  (flatten [["Active LSP clients for this buffer:" ""]
            (flatten (icollect [i client (pairs clients)]
                       (client-lines i client)))]))

(fn header-lines []
  ["LSP Information" "===============" ""])

(fn buffer-info-lines [buf]
  (let [filetype (. vim.bo buf :filetype)
        buf-name (vim.api.nvim_buf_get_name buf)]
    [(.. "Buffer: " (non-empty buf-name "[No Name]"))
     (.. "Filetype: " (non-empty filetype "[No filetype]"))
     (.. "Buffer number: " buf)
     ""]))

(fn footer-lines []
  ["Helpful commands:"
   "  :lua vim.lsp.buf.hover() - Show hover information"
   "  :lua vim.lsp.buf.definition() - Go to definition"
   "  :lua vim.lsp.buf.references() - Find references"
   "  :lua vim.lsp.buf.format() - Format buffer"
   "  :checkhealth lsp - Check LSP health"])

(fn lsp-info-lines [buf]
  (let [clients (vim.lsp.get_clients {:bufnr buf})]
    (flatten [(header-lines)
              (buffer-info-lines buf)
              (if (= (length clients) 0)
                  (no-clients-lines)
                  (active-clients-lines clients))
              (footer-lines)])))

(fn print-lines [lines]
  (each [_ line (ipairs lines)]
    (print line)))

(fn lsp-info-command []
  (print-lines (lsp-info-lines (vim.api.nvim_get_current_buf))))

(vim.api.nvim_create_user_command :LspInfo lsp-info-command
                                  {:desc "Show LSP client information for current buffer"
                                   :force true})
