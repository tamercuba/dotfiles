vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "Hover Documentation")
		map("gs", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, "[S]ignature Documentation")
		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>lr", vim.lsp.buf.rename, "[R]ename all references")
		map("<leader>lf", vim.lsp.buf.format, "[F]ormat")
		map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")
		map("]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Next Diagnostic")
		map("[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Previous Diagnostic")
		map("<leader>vr", require("config.renamer"), "[R]ename buffer")

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, { bufnr = event.buf }) then
		-- 	vim.lsp.codelens.enable(true, { bufnr = event.buf })
		-- end

		if
			client
			and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, { bufnr = event.buf })
		then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

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
	local subpath = rel:match("^src/clj[sc]?/(.+)")
		or rel:match("^test/clj[sc]?/(.+)")
		or rel:match("^src/(.+)")
		or rel:match("^test/(.+)")
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

vim.filetype.add({
	extension = { risp = "risp" },
})

vim.filetype.add({
	pattern = {
		[".*"] = function(_, bufnr)
			local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
			if first_line:match("^#!/usr/bin/env bb") then
				return "clojure"
			end
		end,
	},
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

local function open_jar_entry(buf, jar, entry)
	local content = vim.fn.system({ "unzip", "-p", jar, entry })
	if vim.v.shell_error ~= 0 then
		return
	end
	local lines = vim.split(content, "\n", { trimempty = false })
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].readonly = true
	vim.schedule(function()
		vim.cmd("filetype detect")
	end)
end

vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "zipfile://*",
	callback = function(ev)
		local name = vim.api.nvim_buf_get_name(ev.buf)
		local path = name:gsub("^zipfile://", "")
		local jar, entry = path:match("^(.-)::(.+)$")
		if jar and entry then
			open_jar_entry(ev.buf, jar, entry)
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "jar:file://*",
	callback = function(ev)
		local name = vim.api.nvim_buf_get_name(ev.buf)
		local jar, entry = name:match("^jar:file://(.-)!/(.+)$")
		if jar and entry then
			open_jar_entry(ev.buf, jar, entry)
		end
	end,
})
