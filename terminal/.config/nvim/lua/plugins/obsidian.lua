return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/projects/obsidian-vault/*.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/projects/obsidian-vault/*.md",
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "personal",
					path = "~/projects/obsidian-vault",
				},
			},
			daily_notes = {
				folder = "Nubank/Diarios",
				date_format = "%d-%m-%y",
				default_tags = { "daily-notes" },
				template = "Daily",
			},

			templates = {
				folder = "Templates",
				date_format = "%d-%m-%y",
				time_format = "%H:%M",
			},

			completion = {
				nvim_cmp = false,
				blink = true,
				min_chars = 2,
				create_new = true,
			},
			legacy_commands = false,
		})
		vim.keymap.set("n", "<leader>o", ":Obsidian<CR>", { desc = "[O]bsidian", silent = true })
	end,
}
