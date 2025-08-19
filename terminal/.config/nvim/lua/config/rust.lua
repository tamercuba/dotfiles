vim.g.rustaceanvim = {
	server = {
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					allTargets = true, -- Critical for project-wide checking
				},
				check = {
					command = "clippy",
					allTargets = true, -- Essential for comprehensive error display
				},
			},
		},
	},
}
