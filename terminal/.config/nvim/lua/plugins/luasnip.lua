-- [nfnl] fnl/plugins/luasnip.fnl
local function config()
  local ls = require("luasnip")
  ls.add_snippets("go", {ls.snippet("iferr", {ls.text_node({"if err != nil {", "\treturn "}), ls.insert_node(1, "nil"), ls.text_node({", err", "}"})})})
  return require("luasnip.loaders.from_vscode").lazy_load()
end
return {"L3MON4D3/LuaSnip", config = config}
