return {
	["defund"] = {
		["REPL"] = {
			command = "lein repl",
			cwd = "defund",
		},
	},
	["clojure-lsp"] = {
		["Lib nREPL"] = {
			command = "clojure -M:test:nrepl",
			cwd = "/home/tamer/projects/clojure-lsp/lib",
		},
		["Build Debug CLI"] = {
			command = "bb debug-cli",
			cwd = "/home/tamer/projects/clojure-lsp",
		},
	},
}
