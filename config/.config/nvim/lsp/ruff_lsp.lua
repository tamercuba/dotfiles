-- Configuração do Ruff LSP para Neovim 0.11 usando vim.lsp.config
return {
	cmd = { "ruff", "server", "--preview" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"ruff.toml",
		".ruff.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		logLevel = "info",
		lint = {
			enable = true,
			run = "onType",
		},
		format = {
			enable = true,
		},
	},
	on_attach = function(client, bufnr)
		-- Keymaps específicos para o Ruff
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- Aplicar correções automáticas do Ruff
		vim.keymap.set("n", "<leader>rf", function()
			vim.lsp.buf.code_action({
				filter = function(action)
					return string.match(action.title, "Ruff")
				end,
				apply = true,
			})
		end, opts)

		-- Organizar imports
		vim.keymap.set("n", "<leader>ro", function()
			vim.lsp.buf.code_action({
				filter = function(action)
					return string.match(action.title, "Organize imports")
				end,
				apply = true,
			})
		end, opts)
	end,
}
