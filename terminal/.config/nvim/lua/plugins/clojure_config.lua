return {
	{
		"Olical/conjure",
		ft = { "clojure", "fennel", "janet", "racket", "scheme", "lisp" }, -- Carregar quando abrir arquivos Clojure
		-- <localleader>ls   -  Open log buffer in horizontal split window.
		-- <localleader>lv   -  Open log buffer in vertical split window.
		-- <localleader>E    -  Evaluate visual mode selection.
		-- <localleader>ee   -  Evaluate the form under the cursor.
		-- <localleader>ece  -  Evaluate the form under the cursor and display the result as a comment.
		-- <localleader>er   -  Evaluate the root form under the cursor.
		-- <localleader>ecr  -  Evaluate the root form under the cursor and display the result as a comment.
	},
	{
		"venantius/vim-cljfmt",
		ft = { "clojure" },
	},
	{
		"tpope/vim-dispatch",
		ft = { "clojure" },
	},
	{
		"clojure-vim/vim-jack-in",
		dependencies = { "tpope/vim-dispatch", "radenling/vim-dispatch-neovim" },
		ft = { "clojure" },
	},
	{
		"radenling/vim-dispatch-neovim",
		ft = { "clojure" },
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}

			-- Ativar apenas para linguagens Lisp-like
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "clojure", "edn", "scheme", "lisp", "racket", "fennel" },
				callback = function()
					vim.b.rainbow_delimiters = {
						strategy = rainbow_delimiters.strategy["global"],
						query = "rainbow-delimiters",
					}
				end,
			})

			-- Desativar para todas as outras linguagens
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					local lisp_filetypes = { "clojure", "edn", "scheme", "lisp", "racket", "fennel" }
					local current_ft = vim.bo.filetype

					local is_lisp_like = false
					for _, ft in ipairs(lisp_filetypes) do
						if current_ft == ft then
							is_lisp_like = true
							break
						end
					end

					if not is_lisp_like then
						vim.b.rainbow_delimiters = { strategy = {} }
					end
				end,
			})
		end,
	},
}
