-- return {
-- 	"neanias/everforest-nvim",
-- 	name = "everforest",
-- 	version = false,
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("everforest").setup({
-- 			background = "hard",
-- 		})
-- 		require("everforest").load()
-- 	end,
-- }
return { 
	"catppuccin/nvim", 
	name = "catppuccin", 
	priority = 1000, 
	config = function()
		require("catppuccin").setup({
		  flavour = "macchiato", -- latte, frappe, macchiato, mocha
		  background = {
		  	light = "latte",
			}
		})
	  vim.cmd.colorscheme("catppuccin")
	end,
}
