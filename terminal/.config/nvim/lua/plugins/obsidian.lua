return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	event = {
		"BufReadPre ~/projects/obsidian-vault/*.md",
		"BufNewFile ~/projects/obsidian-vault/*.md",
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
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
	},
}
