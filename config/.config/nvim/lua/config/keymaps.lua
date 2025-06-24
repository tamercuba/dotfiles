local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>fn", function()
	local current_path = vim.api.nvim_buf_get_name(0)
	if current_path == "" then
		vim.notify("Este buffer não está associado a um arquivo salvo.", vim.log.levels.WARN)
		return
	end

	local current_dir = vim.fn.fnamemodify(current_path, ":h")

	vim.ui.input({ prompt = "Nome do novo arquivo: ", completion = "file" }, function(input)
		if not input or input == "" then
			return
		end

		local new_file_path = current_dir .. "/" .. input
		local uv = vim.loop

		-- Cria o arquivo vazio se não existir
		local fd = uv.fs_open(new_file_path, "w", 420) -- 0644
		if not fd then
			vim.notify("Erro ao criar o arquivo: " .. new_file_path, vim.log.levels.ERROR)
			return
		end
		uv.fs_close(fd)

		-- Abre o novo arquivo em um novo buffer
		vim.cmd("edit " .. vim.fn.fnameescape(new_file_path))
	end)
end, { desc = "[N]ew [F]ile", noremap = true, silent = true })

vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Go to right table" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Go to left table" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Go to upper table" })
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Go to bottom table" })
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", opts)
vim.keymap.set("n", "<C-|>", ":split<CR>", opts)

-- Navigate between tabs and terminal
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally", noremap = true, silent = false }
)

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
