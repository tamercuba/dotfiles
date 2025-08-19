return {
	"neanias/everforest-nvim",
	name = "everforest",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		require("everforest").setup({
			background = "hard",
		})
		require("everforest").load()
	end,
}
