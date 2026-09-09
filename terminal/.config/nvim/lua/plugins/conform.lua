-- [nfnl] fnl/plugins/conform.fnl
local disabled_filetypes_to_auto_format = {c = true, cpp = true, dart = true}
local function format()
  local conform = require("conform")
  return conform.format({async = true, lsp_fallback = true})
end
local function format_on_save(bufnr)
  return {timeout_ms = 500, lsp_fallback = not disabled_filetypes_to_auto_format[vim.bo[bufnr].filetype]}
end
return {"stevearc/conform.nvim", keys = {{"<leader>F", format, mode = "", desc = "[F]ormat buffer"}}, opts = {notify_on_error = true, format_on_save = format_on_save, log_level = vim.log.levels.ERROR, formatters_by_ft = {lua = {"stylua"}, go = {"goimports", "golines", "gofmt"}, python = {"ruff_format"}, rust = {"rustfmt"}, javascript = {"prettier"}, typescript = {"prettier"}, javascriptreact = {"prettier"}, typescriptreact = {"prettier"}, sql = {"sql_formatter"}, yaml = {"prettier"}, json = {"prettier"}, jsonc = {"prettier"}, nix = {"alejandra"}, fennel = {"fnlfmt"}}}, lazy = false}
