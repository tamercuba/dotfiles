(local disabled-filetypes-to-auto-format {:c true :cpp true :dart true})
(fn format []
  (let [conform (require :conform)]
    (conform.format {:async true :lsp_fallback true})))

(fn format_on_save [bufnr]
  {:timeout_ms 500
   :lsp_fallback (not (. disabled-filetypes-to-auto-format
                         (. vim.bo bufnr :filetype)))})

{1 :stevearc/conform.nvim
 :lazy false
 :keys [{1 :<leader>F 2 format :mode "" :desc "[F]ormat buffer"}]
 :opts {:notify_on_error true
        : format_on_save
        :log_level vim.log.levels.ERROR
        :formatters_by_ft {:lua [:stylua]
                           :go [:goimports :golines :gofmt]
                           :python [:ruff_format]
                           :rust [:rustfmt]
                           :javascript [:prettier]
                           :typescript [:prettier]
                           :javascriptreact [:prettier]
                           :typescriptreact [:prettier]
                           :sql [:sql_formatter]
                           :yaml [:prettier]
                           :json [:prettier]
                           :jsonc [:prettier]
                           :nix [:alejandra]
                           :fennel [:fnlfmt]}}}
