return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("n", "<leader>gc", function()
			local status = vim.fn.execute("Copilot status")
			if status:match("Ready") then
				vim.cmd("Copilot disable")
				print("Copilot disabled")
			else
				vim.cmd("Copilot enable")
				print("Copilot enabled")
			end
		end, { desc = "Toggle [G]ithub [C]opilot" })
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	end,
}
