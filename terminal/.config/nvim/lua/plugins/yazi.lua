return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>m", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
		{ "<leader>M", "<cmd>Yazi cwd<cr>", desc = "Open yazi in project root" },
	},
	opts = {
		open_for_directories = true,
	},
}
