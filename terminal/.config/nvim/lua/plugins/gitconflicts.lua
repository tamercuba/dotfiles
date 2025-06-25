return {
	"akinsho/git-conflict.nvim",
	version = "*",
	config = function()
		require("git-conflict").setup()
		vim.api.nvim_set_keymap(
			"n",
			"<leader>go",
			"<cmd>GitConflictChooseOurs<CR>",
			{ noremap = true, silent = true, desc = "[G]it conflict: choose [O]urs" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gt",
			"<cmd>GitConflictChooseTheirs<CR>",
			{ noremap = true, silent = true, desc = "[G]it conflict: choose [T]heirs" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gb",
			"<cmd>GitConflictChooseBoth<CR>",
			{ noremap = true, silent = true, desc = "[G]it conflict: choose [B]oth" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gn",
			"<cmd>GitConflictChooseNone<CR>",
			{ noremap = true, silent = true, desc = "[G]it conflict: choose [N]one" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gj",
			"<cmd>GitConflictNextConflict<CR>",
			{ noremap = true, silent = true, desc = "[G]it conflict: next conflict" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gk",
			"<cmd>GitConflictPrevConflict<CR>",
			{ noremap = true, silent = true, desc = "[G]it conflict: prev conflict" }
		)
	end,
}
