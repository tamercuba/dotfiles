return {
	cmd = { "metals" },
	filetypes = { "scala", "sbt" },
	root_markers = {
		"build.sbt",
		"build.sc",
		"build.gradle",
		"pom.xml",
		".git",
	},
	settings = {
		showImplicitArguments = true,
		showInferredType = true,
		superMethodLensesEnabled = true,
	},
	init_options = {
		statusBarProvider = "on",
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
