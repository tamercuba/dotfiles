return {
	{
		"Olical/conjure",
		dependencies = { "PaterJason/cmp-conjure" },
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
		"PaterJason/cmp-conjure",
		dependencies = { "hrsh7th/nvim-cmp" },
		ft = { "clojure" },
		config = function()
			local cmp = require("cmp")
			local config = cmp.get_config()
			table.insert(config.sources, { name = "conjure" })
			cmp.setup(config)
		end,
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
		"luochen1990/rainbow",

		ft = { "clojure" },
		config = function()
			vim.g.rainbow_active = 1
			vim.g.rainbow_conf = {
				guifont = "Fira Code",
				guifontwide = "Fira Code",
				guifontbold = "Fira Code",
				guifontitalic = "Fira Code",
			}
		end,
	},
}
