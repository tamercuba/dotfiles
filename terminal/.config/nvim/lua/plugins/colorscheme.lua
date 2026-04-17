return {
	"f4z3r/gruvbox-material.nvim",
	name = "gruvbox-material",
	lazy = false,
	priority = 1000,
	opts = {
		contrast = "hard",
		background = {
			transparent = true,
		},
	},
	config = function(_, opts)
		require("gruvbox-material").setup(opts)
		vim.cmd.colorscheme("gruvbox-material")

		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#665c54", bg = "#282828" })

		vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1d3520" })
		vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1d3520" })
		vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3d1a1a" })
		vim.api.nvim_set_hl(0, "DiffText", { bg = "#1d3520" })
	end,
}
