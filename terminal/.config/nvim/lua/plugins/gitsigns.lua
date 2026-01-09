return {
	"lewis6991/gitsigns.nvim",
	tag = "v0.9.0",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				relative_time = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		})
		vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "[G]it [P]review Hunk" })
		vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "[G]it [R]eset Hunk" })
		vim.keymap.set("n", "<leader>ghn", ":Gitsigns next_hunk<CR>", { desc = "[G]it [N]ext Hunk" })
		vim.keymap.set("n", "<leader>ghp", ":Gitsigns prev_hunk<CR>", { desc = "[G]it [P]revious Hunk" })
		vim.keymap.set("n", "<leader>gha", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [H]unk [A]dd"})
	end,
}
