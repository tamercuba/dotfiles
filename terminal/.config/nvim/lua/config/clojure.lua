vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
vim.g["conjure#client#clojure#nrepl#eval#pretty_print"] = true
vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#client#clojure#nrepl#test#runner"] = "clojure"
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

vim.api.nvim_create_user_command("ConjureGo", function()
	vim.cmd("ConjureConnect")
end, {desc = "Conecta o Conjure ao REPL"})
