return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "Cargo.lock", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			-- SOLUÇÃO PRINCIPAL: desabilita verificação apenas ao salvar
			checkOnSave = false,
			
			cargo = {
				allFeatures = true,
				buildScripts = { enable = true },
			},
			diagnostics = {
				enable = true,
				experimental = { enable = true }
			}
			
		},
	},
}
