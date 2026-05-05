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
	["clj_data_structures"] = {
		["REPL"] = {
			command = "lein repl",
			cwd = "clj_data_structures",
		},
	},
	["musubi"] = {
		["BB REPL"] = {
			command = "bb nrepl",
			cwd = "musubi",
		},
	},
}
