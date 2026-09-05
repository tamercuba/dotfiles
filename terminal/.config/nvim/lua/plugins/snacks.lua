local exclude = {
	"node_modules",
	".git",
	"*.lock",
	"target",
	".clj-kondo",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			-- replaces telescope-ui-select as the `vim.ui.select` handler
			ui_select = true,
			sources = {
				files = {
					hidden = true,
					exclude = exclude,
				},
				grep = {
					hidden = true,
					exclude = exclude,
				},
			},
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.files({
					layout = { preset = "vertical", hidden = { "preview" } },
				})
			end,
			desc = "[F]ind [F]iles",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "[F]ind [G]rep",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[F]ind [B]uffer",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "[F]ind [R]eferences",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[F]ind [D]iagnostics",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "[F]ind [S]tatus",
		},
		{
			"<leader>fi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "[F]ind [I]mplementations",
		},
		{
			"<leader>fu",
			function()
				Snacks.picker.git_diff({ group = true })
			end,
			desc = "[F]ind [U]nstaged",
		},
		-- Closest replacement for telescope-smart-history: reopen the last picker
		-- with its query and results intact.
		{
			"<leader>fp",
			function()
				Snacks.picker.resume()
			end,
			desc = "[F]ind [P]revious (resume)",
		},
	},
}
