-- [nfnl] fnl/config/autocmds/lsp.fnl
local function lsp_map(buf, keys, func, desc)
  return vim.keymap.set("n", keys, func, {buffer = buf, desc = ("LSP: " .. desc)})
end
local function hover()
  return vim.lsp.buf.hover({border = "rounded"})
end
local function signature_help()
  return vim.lsp.buf.signature_help({border = "rounded"})
end
local function next_diagnostic()
  return vim.diagnostic.jump({count = 1, float = true})
end
local function prev_diagnostic()
  return vim.diagnostic.jump({count = -1, float = true})
end
local function lsp_keymap_specs()
  return {{"gl", vim.diagnostic.open_float, "Open Diagnostic Float"}, {"K", hover, "Hover Documentation"}, {"gs", signature_help, "[S]ignature Documentation"}, {"gd", vim.lsp.buf.definition, "[G]oto [D]efinition"}, {"<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction"}, {"<leader>lr", vim.lsp.buf.rename, "[R]ename all references"}, {"<leader>lf", vim.lsp.buf.format, "[F]ormat"}, {"<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split"}, {"]d", next_diagnostic, "Next Diagnostic"}, {"[d", prev_diagnostic, "Previous Diagnostic"}, {"<leader>vr", require("config.renamer"), "[R]ename buffer"}}
end
local function bind_lsp_keymaps(buf)
  for _, _1_ in ipairs(lsp_keymap_specs()) do
    local keys = _1_[1]
    local func = _1_[2]
    local desc = _1_[3]
    lsp_map(buf, keys, func, desc)
  end
  return nil
end
local function clear_lsp_highlight(event)
  vim.lsp.buf.clear_references()
  return vim.api.nvim_clear_autocmds({group = "lsp-highlight", buffer = event.buf})
end
local function setup_document_highlight(buf)
  local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", {clear = false})
  vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {buffer = buf, group = highlight_augroup, callback = vim.lsp.buf.document_highlight})
  vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {buffer = buf, group = highlight_augroup, callback = vim.lsp.buf.clear_references})
  return vim.api.nvim_create_autocmd("LspDetach", {group = vim.api.nvim_create_augroup("lsp-detach", {clear = true}), callback = clear_lsp_highlight})
end
local function supports_document_highlight_3f(client, buf)
  return (client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, {bufnr = buf}))
end
local function on_lsp_attach(event)
  bind_lsp_keymaps(event.buf)
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if supports_document_highlight_3f(client, event.buf) then
    return setup_document_highlight(event.buf)
  else
    return nil
  end
end
return vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("lsp-attach", {clear = true}), callback = on_lsp_attach})
