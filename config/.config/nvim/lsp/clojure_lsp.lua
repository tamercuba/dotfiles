return {
	cmd = { "clojure-lsp" },
	filetypes = { "clojure", "edn" },
	opts = {
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
	},
}
