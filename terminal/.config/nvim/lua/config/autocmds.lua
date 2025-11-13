vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gs", vim.lsp.buf.signature_help, "[S]ignature Documentation")
		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>lr", vim.lsp.buf.rename, "[R]ename all references")
		map("<leader>lf", vim.lsp.buf.format, "[F]ormat")
		map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")
		map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
		map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
		map("<leader>vr", require("config.renamer"), "[R]ename buffer")

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			-- When cursor stops moving: Highlights all instances of the symbol under the cursor
			-- When cursor moves: Clears the highlighting
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- When LSP detaches: Clears the highlighting
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})
vim.api.nvim_create_user_command("ConjureGo", function()
	vim.cmd("ConjureConnect")
end, { desc = "Conecta o Conjure ao REPL" })

local function insert_clojure_ns_if_needed(args)
	-- This check is necessary because neotree doesnt use BufNewFile
	-- So any empty clj file under the follow criteria will get the ns inserted
	local buf = args.buf
	if vim.api.nvim_buf_line_count(buf) > 1 then
		return
	end
	local file = vim.api.nvim_buf_get_name(buf)
	if file == "" then
		return
	end

	local dir = vim.fs.dirname(file)
	local marker = vim.fs.find({ "deps.edn", "project.clj" }, { upward = true, path = dir, type = "file" })[1]
	if not marker then
		return
	end
	local root = vim.fs.dirname(marker)

	local rel = file:sub(#root + 2) -- path relative to root
	local subpath = rel:match("^src/(.+)") or rel:match("^test/(.+)")
	if not subpath then
		return
	end
	if not subpath:match("%.clj$") then
		return
	end
	subpath = subpath:gsub("%.clj$", "")

	local ns = subpath:gsub("/", "."):gsub("_", "-")
	ns = ns:gsub("^%.*", "")
	if ns == "" then
		return
	end

	local existing = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
	if existing and existing ~= "" then
		return
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "(ns " .. ns .. ")", "" })
	vim.api.nvim_buf_set_mark(buf, "n", 1, 1, {})
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.clj",
	callback = insert_clojure_ns_if_needed,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.clj", "*.cljs", "*.cljc", "*.edn" },
	callback = function()
		local total_lines = vim.api.nvim_buf_line_count(0)
		local last_nonblank = vim.fn.prevnonblank(total_lines)
		
		if last_nonblank < total_lines - 1 then
			vim.api.nvim_buf_set_lines(0, last_nonblank + 1, total_lines, false, {})
		end
	end,
})

-- Setup Avante after Neovim fully loads (essential because lazy.nvim config isn't being called)
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("avante-setup", { clear = true }),
	once = true,
	callback = function()
		local endpoint = os.getenv("LITELLM_ENDPOINT")
		if not endpoint then
			return -- Don't setup Avante if no endpoint is configured
		end

		vim.schedule(function()
			local ok, avante = pcall(require, "avante")
			if not ok then
				return -- Avante not installed
			end

			avante.setup({
				instructions_file = "avante.md",
				provider = "litellm",
				providers = {
					litellm = {
						__inherited_from = "openai",
						endpoint = endpoint,
						api_key_name = "LITELLM_API_KEY",
						model = "openai/gpt-5",
						timeout = 30000,
						extra_request_body = {
							temperature = 1,
							max_tokens = 8192,
						},
					},
				},
			})
		end)
	end,
})
