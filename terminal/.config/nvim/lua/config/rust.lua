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
				completion = {
					autoimport = { enable = true },
					autoself = { enable = true },
				},
				imports = {
					granularity = {
						group = "module",
						enforce = true,
					},
					prefix = "self",
				},
			},
		},
	},
}
