return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
"nvim-telescope/telescope-smart-history.nvim",
			"kkharji/sqlite.lua",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

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
vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "[F]ind [S]tatus" })
			vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "[F]ind [I]mplementations" })
			vim.keymap.set("n", "<leader>fu", function()
				builtin.find_files({
					find_command = { "git", "diff", "--name-only", "--diff-filter=d", "--relative" },
					prompt_title = "Unstaged Changes",
				})
			end, { desc = "[F]ind [U]nstaged" })

			require("telescope").setup({
				defaults = {
					history = {
						path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
						limit = 100,
					},
					mappings = {
						i = {
							["<C-p>"] = require("telescope.actions").cycle_history_prev,
							["<C-n>"] = require("telescope.actions").cycle_history_next,
						},
					},
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
				pickers = {
					find_files = {
						hidden = true,
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
			})

pcall(require("telescope").load_extension, "smart_history")
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
