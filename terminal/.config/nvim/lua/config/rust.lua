vim.g.rustaceanvim = {
	server = {
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					allTargets = true,
				},
				check = {
					command = "clippy",
					allTargets = true,
				},
			},
		},
	},
}
