return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		ls.add_snippets("go", {
			s("iferr", {
				t({ "if err != nil {", "\treturn " }),
				i(1, "nil"),
				t({ ", err", "}" }),
			}),
		})

		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
