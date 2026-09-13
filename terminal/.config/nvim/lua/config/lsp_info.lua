-- [nfnl] fnl/config/lsp_info.fnl
local function non_empty(s, fallback)
  if (s == "") then
    return fallback
  else
    return s
  end
end
local function flatten(lists)
  local result = {}
  for _, lines in ipairs(lists) do
    for _0, line in ipairs(lines) do
      table.insert(result, line)
    end
  end
  return result
end
local capability_map = {{"completionProvider", "completion"}, {"hoverProvider", "hover"}, {"definitionProvider", "goto_definition"}, {"referencesProvider", "find_references"}, {"documentFormattingProvider", "formatting"}, {"renameProvider", "rename"}, {"codeActionProvider", "code_actions"}}
local function capability_labels(caps)
  if caps then
    local tbl_26_ = {}
    local i_27_ = 0
    for _, _2_ in ipairs(capability_map) do
      local key = _2_[1]
      local label = _2_[2]
      local val_28_
      if caps[key] then
        val_28_ = label
      else
        val_28_ = nil
      end
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    return tbl_26_
  else
    return {}
  end
end
local function attached_buffers_str(client)
  local _6_
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for _, attached_buf in pairs(client.attached_buffers) do
      local val_28_ = tostring(attached_buf)
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    _6_ = tbl_26_
  end
  return table.concat(_6_, ", ")
end
local function other_buffer_client_line(client)
  return string.format("  - %s (id: %d, buffers: %s)", client.name, client.id, attached_buffers_str(client))
end
local function no_clients_lines()
  local all_clients = vim.lsp.get_clients()
  if (#all_clients > 0) then
    local function _8_()
      local tbl_26_ = {}
      local i_27_ = 0
      for _, client in pairs(all_clients) do
        local val_28_ = other_buffer_client_line(client)
        if (nil ~= val_28_) then
          i_27_ = (i_27_ + 1)
          tbl_26_[i_27_] = val_28_
        else
        end
      end
      return tbl_26_
    end
    return flatten({{"Available LSP clients (attached to other buffers):"}, _8_()})
  else
    return {"No LSP clients running"}
  end
end
local function client_filetypes_str(client)
  if client.config.filetypes then
    return table.concat(client.config.filetypes, ", ")
  else
    return "Not specified"
  end
end
local function client_capabilities_line(client)
  local labels = capability_labels(client.server_capabilities)
  if (#labels > 0) then
    return {("  - capabilities: " .. table.concat(labels, ", "))}
  else
    return {}
  end
end
local function client_lines(i, client)
  local _13_
  if (i == 1) then
    _13_ = {("  - log file: " .. vim.lsp.get_log_path())}
  else
    _13_ = {}
  end
  return flatten({{string.format("Client %d: %s", i, client.name), ("  - id: " .. client.id), ("  - root directory: " .. (client.config.root_dir or "Not set")), ("  - filetypes: " .. client_filetypes_str(client))}, client_capabilities_line(client), {("  - attached buffers: " .. attached_buffers_str(client))}, _13_, {""}})
end
local function active_clients_lines(clients)
  local function _15_()
    local tbl_26_ = {}
    local i_27_ = 0
    for i, client in pairs(clients) do
      local val_28_ = client_lines(i, client)
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    return tbl_26_
  end
  return flatten({{"Active LSP clients for this buffer:", ""}, flatten(_15_())})
end
local function header_lines()
  return {"LSP Information", "===============", ""}
end
local function buffer_info_lines(buf)
  local filetype = vim.bo[buf].filetype
  local buf_name = vim.api.nvim_buf_get_name(buf)
  return {("Buffer: " .. non_empty(buf_name, "[No Name]")), ("Filetype: " .. non_empty(filetype, "[No filetype]")), ("Buffer number: " .. buf), ""}
end
local function footer_lines()
  return {"Helpful commands:", "  :lua vim.lsp.buf.hover() - Show hover information", "  :lua vim.lsp.buf.definition() - Go to definition", "  :lua vim.lsp.buf.references() - Find references", "  :lua vim.lsp.buf.format() - Format buffer", "  :checkhealth lsp - Check LSP health"}
end
local function lsp_info_lines(buf)
  local clients = vim.lsp.get_clients({bufnr = buf})
  local _17_
  if (#clients == 0) then
    _17_ = no_clients_lines()
  else
    _17_ = active_clients_lines(clients)
  end
  return flatten({header_lines(), buffer_info_lines(buf), _17_, footer_lines()})
end
local function print_lines(lines)
  for _, line in ipairs(lines) do
    print(line)
  end
  return nil
end
local function lsp_info_command()
  return print_lines(lsp_info_lines(vim.api.nvim_get_current_buf()))
end
return vim.api.nvim_create_user_command("LspInfo", lsp_info_command, {desc = "Show LSP client information for current buffer", force = true})
