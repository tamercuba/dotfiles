return {
	cmd = { "sql-language-server", "up", "--method", "stdio" },
	filetypes = { "sql" },
	root_dir = function(fname)
		return vim.fs.dirname(fname)
	end,
}
