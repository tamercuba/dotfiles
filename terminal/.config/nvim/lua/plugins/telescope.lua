return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			
			-- Find files without preview - better for large codebases
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					previewer = false,
					layout_strategy = "vertical",
					layout_config = {
						width = 0.9,
						height = 0.9,
					},
				})
			end, { desc = "[F]ind [F]iles" })
			
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffer" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [Help]" })
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "[F]ind [R]eferences" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
			
			require("telescope").setup({
				defaults = {
					layout_config = {
						horizontal = {
							preview_width = 0.3,
						},
						vertical = {
							preview_width = 0.3,
						},
					},
					file_ignore_patterns = {
						"node_modules/",
						".git/",
						"%.lock",
						"target/",
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
