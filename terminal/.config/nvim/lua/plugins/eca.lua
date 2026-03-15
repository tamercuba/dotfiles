return {
	-- "editor-code-assistant/eca-nvim",
	dir = "~/projects/eca-nvim", -- local path takes priority
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
	},
	keys = {
		{ "<leader>ec", "<cmd>EcaChat<cr>", desc = "Open ECA chat" },
		{ "<leader>ef", "<cmd>EcaFocus<cr>", desc = "Focus ECA sidebar" },
		{ "<leader>et", "<cmd>EcaToggle<cr>", desc = "Toggle ECA sidebar" },
		{ "<leader>ea", "<cmd>EcaChatAddFile<cr>", desc = "Add current file to ECA chat" },
		{ "<leader>ea", "<cmd>EcaChatAddSelection<cr>", mode = "x", desc = "Add selection to ECA chat" },
		{
			"<leader>eA",
			function()
				require("telescope.builtin").find_files({
					prompt_title = "Add file to ECA chat",
					attach_mappings = function(_, map)
						map("i", "<CR>", function(prompt_bufnr)
							local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
							require("telescope.actions").close(prompt_bufnr)
							vim.cmd("EcaChatAddFile " .. selection.path)
						end)
						return true
					end,
				})
			end,
			desc = "Pick file to add to ECA chat",
		},
	},
	opts = {
		debug = false,
		server_path = "",
		behavior = {
			auto_set_keymaps = true,
			auto_focus_sidebar = true,
			auto_start_server = true,
			preserve_chat_history = true,
		},
		windows = {
			edit = {
				start_insert = false,
			},
		},
	},
}
