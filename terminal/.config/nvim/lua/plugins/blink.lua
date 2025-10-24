-- Check if Avante is available (only on work machine with LITELLM_ENDPOINT set)
local avante_available = os.getenv("LITELLM_ENDPOINT") ~= nil

return {
	{ "saghen/blink.compat", version = "*", lazy = true },
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = vim.list_extend({
			"rafamadriz/friendly-snippets",
			"PaterJason/cmp-conjure",
			"mikavilpas/blink-ripgrep.nvim",
			"L3MON4D3/LuaSnip",
		}, avante_available and { "Kaiser-Yang/blink-cmp-avante" } or {}),
		opts = {
			keymap = {
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				-- Copilot compatibility
				["<Tab>"] = {},
				["<S-Tab>"] = {},
				["<C-f>"] = {},
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
			},
			cmdline = {
				enabled = false,
				completion = { menu = { auto_show = true } },
				keymap = {
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
			},
			completion = {
				menu = {
					border = nil,
					scrolloff = 1,
					scrollbar = false,
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
							{ "source_name" },
						},
					},
				},
				documentation = {
					window = {
						border = nil,
						scrollbar = false,
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					},
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = "mono" },
			snippets = { preset = "luasnip" },
			sources = {
				default = vim.list_extend({
					"lsp",
					"path",
					"snippets",
					"buffer",
					"conjure",
				}, avante_available and { "avante" } or {}),
				providers = vim.tbl_extend("force", {
					conjure = { name = "conjure", module = "blink.compat.source", score_offset = -3 },
				}, avante_available and {
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						score_offset = 100, -- Show avante items at the top
					},
				} or {}),
			},
		},
		lazy = false,
	},
}
