return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iff View" },
		{ "<leader>gD", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "[G]it [D]iff vs Last Commit" },
		{ "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it [F]ile History (current)" },
		{ "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it [F]ile History (all)" },
	},
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			keymaps = {
				view = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					{ "n", "]f", actions.select_next_entry, { desc = "Next file" } },
					{ "n", "[f", actions.select_prev_entry, { desc = "Previous file" } },
				},
				file_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					{ "n", "]f", actions.select_next_entry, { desc = "Next file" } },
					{ "n", "[f", actions.select_prev_entry, { desc = "Previous file" } },
				},
				file_history_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
				},
			},
			hooks = {
				diff_buf_win_enter = function()
					vim.opt_local.foldenable = false
					vim.opt_local.fillchars:append("diff: ")
				end,
			},
		})
	end,
}
