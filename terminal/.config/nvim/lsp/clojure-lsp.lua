return {
	cmd = { "clojure-lsp" },
	on_attach = function(client)
		-- Disable semantic tokens so TreeSitter highlighting takes priority
		-- This prevents clojure-lsp from overriding s/defn, s/def etc. colors
		client.server_capabilities.semanticTokensProvider = nil
	end,
	filetypes = { "clojure", "edn" },
	root_markers = {
		"project.clj",
		"deps.edn",
		"build.boot",
		"shadow-cljs.edn",
		"bb.edn",
		".git",
	},
	settings = {
		clojure = {
			format = {
				provider = "cljfmt",
			},
			lint = {
				lintOnChange = true,
				lintOnSave = true,
				lintOnReplLoad = true,
			},
			repl = {
				type = "clj",
				autoStart = true,
			},
		},
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
