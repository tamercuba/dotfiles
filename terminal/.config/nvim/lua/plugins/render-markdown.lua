return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	keys = {
		{
			"<leader>pm",
			"<cmd>MarkdownPreviewToggle<cr>",
			ft = "markdown",
			desc = "Markdown Preview",
		},
	},
	build = function()
		require("lazy").load({ plugins = { "markdown-preview.nvim" } })
		vim.fn["mkdp#util#install"]()
	end,
}
