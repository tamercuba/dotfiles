-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme catppuccin-mocha")
-- 	end,
-- 	transparent_background = true,
-- 	integrations = {
-- 		alpha = true,
-- 		gitsigns = true,
-- 		mason = true,
-- 		neotree = true,
-- 		cmp = true,
-- 		which_key = true,
-- 	},
-- }
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.o.background = "dark"
-- 		vim.cmd("colorscheme gruvbox")
-- 	end,
-- }

return {
	"shaunsingh/nord.nvim",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme nord")
	end,
}
