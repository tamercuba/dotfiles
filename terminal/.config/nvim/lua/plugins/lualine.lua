return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function filename_with_path()
			local filepath = vim.fn.expand("%:p")
			local filename = vim.fn.expand("%:t")
			local directory = vim.fn.fnamemodify(filepath, ":h:t")
			if directory == "." then
				return filename
			else
				return directory .. "/" .. filename
			end
		end

		require("lualine").setup({
			options = {
				theme = "catppuccin",
				--        theme = 'onedark',
			},
			sections = {
				lualine_c = { filename_with_path },
			},
		})
	end,
}
