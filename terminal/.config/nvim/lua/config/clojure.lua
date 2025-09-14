vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
vim.g["conjure#client#clojure#nrepl#eval#pretty_print"] = true
vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#client#clojure#nrepl#test#runner"] = "clojure"
vim.g["conjure#completion#enabled"] = true
vim.g["conjure#completion#omnifunc"] = "v:lua.require'blink.cmp'.omnifunc"
vim.g["conjure#mapping#doc_word"] = false -- Let LSP handle K
vim.g["conjure#log#hud#enabled"] = false -- Use buffer, not popup
vim.g["conjure#mapping#log_vsplit"] = false
vim.g["conjure#mapping#log_tab"] = false

vim.api.nvim_create_augroup("LeinBackground", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "LeinBackground",
	pattern = "clojure",
	callback = function()
		-- Verificar se é projeto Lein
		if vim.fn.filereadable("project.clj") == 1 then
			-- Verificar se já não está rodando checando o arquivo .nrepl-port
			if vim.fn.filereadable(".nrepl-port") == 0 then
				-- Executar Lein criando explicitamente o arquivo .nrepl-port
				vim.fn.jobstart("cd " .. vim.fn.getcwd() .. " && lein repl :headless", {
					detach = true,
					on_exit = function(_, code)
						if code ~= 0 then
							print("Erro ao iniciar Lein REPL")
						end
					end,
				})
			end
		end
	end,
})
