-- [nfnl] fnl/core/lsp.fnl
vim.lsp.enable({"lua_ls", "pyright", "gopls", "ruff", "ruff_lsp", "ts_ls", "clojure-lsp", "eslint", "nixd", "yamlls", "dartls", "metals", "fennel_ls"})
vim.lsp.log.set_level("OFF")
return vim.diagnostic.config({virtual_text = true, underline = true, severity_sort = true, float = {border = "rounded", source = true}, signs = {text = {[vim.diagnostic.severity.ERROR] = "\243\176\133\154 ", [vim.diagnostic.severity.WARN] = "\243\176\128\170 ", [vim.diagnostic.severity.INFO] = "\243\176\139\189 ", [vim.diagnostic.severity.HINT] = "\243\176\140\182 "}}, numhl = {[vim.diagnostic.severity.ERROR] = "ErrorMsg", [vim.diagnostic.severity.WARN] = "WarningMsg"}, update_in_insert = false})
