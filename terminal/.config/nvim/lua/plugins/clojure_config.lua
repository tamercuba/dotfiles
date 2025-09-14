return {
	{
		"Olical/conjure",
		ft = { "clojure", "fennel", "janet", "racket", "scheme", "lisp" }, -- Carregar quando abrir arquivos Clojure
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
}
