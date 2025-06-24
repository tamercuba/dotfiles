return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local wk = require("which-key")

		wk.setup({
			silent = true,
			disable = { warnings = true },
		})

		-- Novo formato de grupo sugerido pelo warning
		wk.add({
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>v", group = "LSP" },
			{ "<leader>h", group = "Git [H]unk", mode = "v" },
		})
	end,
}
