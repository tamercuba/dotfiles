return {
	"VidocqH/lsp-lens.nvim",
	event = "LspAttach",
	opts = {
		enable = true,
		include_declaration = false, 
		sections = {
			definition = false, 
			references = true, 
			implements = true, 
			git_authors = false, 
		},
		ignore_filetype = {
			"markdown",
		},
		-- Customize the virtual text appearance
		target_symbol_kinds = {
			vim.lsp.protocol.SymbolKind.Function,
			vim.lsp.protocol.SymbolKind.Method,
			vim.lsp.protocol.SymbolKind.Interface,
			vim.lsp.protocol.SymbolKind.Class,
			vim.lsp.protocol.SymbolKind.Struct,
		},
	},
	config = function(_, opts)
		require("lsp-lens").setup(opts)
	end,
}

