return {
	{ "L3MON4D3/LuaSnip", keys = {} },
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"PaterJason/cmp-conjure",
		ft = { "clojure", "fennel", "janet" },
		dependencies = { "Olical/conjure" },
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saghen/blink.compat",
		},
		version = "*",
		config = function()
			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				signature = { enabled = true },
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "normal",
				},
				fuzzy = {
					sorts = {
						"score",
					},
				},

				sources = {
					default = { "lsp", "path", "snippets", "buffer" },

					per_filetype = {
						clojure = { "conjure", "lsp", "path", "snippets", "buffer" },
						fennel = { "conjure", "lsp", "path", "snippets", "buffer" },
						janet = { "conjure", "lsp", "path", "snippets", "buffer" },
					},
					providers = {
						cmdline = {
							min_keyword_length = 2,
						},
						conjure = {
							name = "conjure",
							module = "blink.compat.source",
							opts = {
								source = "cmp_conjure",
							},
						},
						lsp = {
							name = "lsp",
							transform_items = function(ctx, items)
								local filetype = vim.bo.filetype
								local lisp_types = { "clojure", "fennel", "janet" }

								-- Só aplica deduplicação para arquivos Lisp
								local is_lisp = false
								for _, ft in ipairs(lisp_types) do
									if filetype == ft then
										is_lisp = true
										break
									end
								end

								-- Se não for Lisp, retorna items normalmente (performance máxima)
								if not is_lisp then
									return items
								end

								-- Para arquivos Lisp: remove duplicatas do LSP que já existem no conjure
								-- (isso só funciona se conseguirmos acessar os items do conjure)

								-- Estratégia 1: Marcar items do LSP para remoção posterior
								local filtered_items = {}
								local lsp_labels = {}

								-- Primeiro pass: coletar labels do LSP
								for _, item in ipairs(items) do
									lsp_labels[item.label] = item
								end

								-- Como não temos acesso direto aos items do conjure aqui,
								-- vamos usar uma abordagem de priority/scoring
								for _, item in ipairs(items) do
									-- Reduz score de items do LSP em arquivos Lisp
									-- para que conjure tenha prioridade visual
									if item.score then
										item.score = item.score - 100 -- penalty para LSP em arquivos Lisp
									end
									table.insert(filtered_items, item)
								end

								return filtered_items
							end,
						},
					},
				},
				keymap = {
					["<C-j>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<CR>"] = { "accept", "fallback" },
					-- Desabilitar Tab (para deixar livre pro Copilot)
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
			})

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
