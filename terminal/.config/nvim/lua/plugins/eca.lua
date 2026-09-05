return {
	"editor-code-assistant/eca-nvim",
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
		{ "<leader>eb", "<cmd>EcaChatSelectBehavior<cr>", desc = "Select ECA chat behavior" },
		{ "<leader>em", "<cmd>EcaChatSelectModel<cr>", desc = "Select ECA chat model" },
		{ "<leader>es", "<cmd>EcaStopResponse<cr>", desc = "Stop ECA response" },
		{ "<leader>en", "<cmd>EcaChatClear<cr>", desc = "Clear ECA chat" },
		{ "<leader>er", "<cmd>EcaServerRestart<cr>", desc = "Restart ECA server" },
		{ "<leader>el", "<cmd>EcaChatListContexts<cr>", desc = "List ECA chat contexts" },
		{ "<leader>ek", "<cmd>EcaChatClearContexts<cr>", desc = "Clear ECA chat contexts" },
		{ "<leader>ea", "<cmd>EcaChatAddSelection<cr>", mode = "x", desc = "Add selection to ECA chat" },
		{
			"<leader>eA",
			function()
				Snacks.picker.files({
					title = "Add file to ECA chat",
					confirm = function(picker, item)
						picker:close()
						if item then
							local path = Snacks.picker.util.path(item)
							if path then
								vim.cmd("EcaChatAddFile " .. vim.fn.fnameescape(path))
							end
						end
					end,
				})
			end,
			desc = "Pick file to add to ECA chat",
		},
	},
	opts = {
		debug = false,
		server_path = "",
		log = {
			level = vim.log.levels.DEBUG,
		},
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
