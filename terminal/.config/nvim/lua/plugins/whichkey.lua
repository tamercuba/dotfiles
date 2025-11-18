return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local wk = require("which-key")
		wk.setup({
			preset = "modern",
			filter = function(mapping)
				return mapping.desc and mapping.desc ~= ""
			end,
		})

		wk.add({
			-- File & Search operations
			{ "<leader>f", group = "󰈞 Find" },
			{ "<leader>ff", desc = "Find Files" },
			{ "<leader>fg", desc = "Live Grep" },
			{ "<leader>fb", desc = "Find Buffers" },
			{ "<leader>fh", desc = "Find Help" },
			{ "<leader>fn", desc = "New File" },

			-- Git operations
			{ "<leader>g", group = "󰊢 Git" },
			{ "<leader>go", desc = "Choose Ours" },
			{ "<leader>gt", desc = "Choose Theirs" },
			{ "<leader>gb", desc = "Choose Both" },
			{ "<leader>gn", desc = "Choose None" },
			{ "<leader>gj", desc = "Next Conflict" },
			{ "<leader>gk", desc = "Prev Conflict" },
			{ "<leader>gp", desc = "Preview Hunk" },
			{ "<leader>gc", desc = "Toggle Copilot" },

			-- Harpoon navigation
			{ "<leader>h", group = "󰛢 Harpoon" },
			{ "<leader>a", desc = "Add to Harpoon" },
			{ "<leader>h1", desc = "Harpoon 1" },
			{ "<leader>h2", desc = "Harpoon 2" },
			{ "<leader>h3", desc = "Harpoon 3" },
			{ "<leader>h4", desc = "Harpoon 4" },
			{ "<leader>hc", desc = "Clear Harpoon" },

			-- LSP operations
			{ "<leader>l", group = "󰿘 LSP" },
			{ "<leader>lr", desc = "Rename" },
			{ "<leader>lf", desc = "Format" },

			-- Code actions
			{ "<leader>c", group = "󰅱 Code" },
			{ "<leader>ca", desc = "Code Action" },

			-- Panel/Window management
			{ "<leader>p", group = "󰽉 Panel" },
			{ "<leader>pn", desc = "New Vertical" },
			{ "<leader>ph", desc = "New Horizontal" },
			{ "<leader>prl", desc = "Resize Right" },
			{ "<leader>prh", desc = "Resize Left" },
			{ "<leader>prk", desc = "Resize Up" },
			{ "<leader>prj", desc = "Resize Down" },

			-- File explorer
			{ "<leader>m", desc = "󰙅 Toggle Neo-tree" },

			-- Search and replace
			{ "<leader>s", desc = "󰛔 Replace Word" },

			-- Vim operations
			{ "<leader>v", desc = "󰕷 Goto Definition (Split)" },

			-- Format
			{ "<leader>F", desc = "󰉤 Format Buffer" },

			-- Visual mode specific
			{ "<leader>h", group = "Git Hunk", mode = "v" },
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "clojure", "fennel", "scheme" },
			callback = function()
				wk.add({
					{ "<localleader>p", group = "󱗘 Paredit" },

					{ "<localleader>ps", desc = "Slurp forwards" },
					{ "<localleader>pS", desc = "Slurp backwards" },

					{ "<localleader>pb", desc = "Barf forwards" },
					{ "<localleader>pB", desc = "Barf backwards" },

					{ "<localleader>pf", desc = "Select current form" },
					{ "<localleader>pF", desc = "Select form content" },

					{ "<localleader>pn", desc = "New empty form ()" },
					{ "<localleader>pw", desc = "Wrap symbol with ()" },
					{ "<localleader>pW", desc = "Wrap form with ()" },

					{ "<localleader>r", group = " REPL" },
					{ "<localleader>rp", desc = "Restart REPL" },
					{ "<localleader>mr", desc = "REPL Picker" },
				})
			end,
		})
	end,
}

