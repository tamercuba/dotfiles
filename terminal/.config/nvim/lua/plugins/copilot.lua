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
		vim.keymap.set("i", "<Tab>", function()
			local copilot_suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
			if copilot_suggestion and copilot_suggestion.text and copilot_suggestion.text ~= "" then
				return vim.fn["copilot#Accept"]()
			end
			return "<Tab>"
		end, { expr = true, silent = true })
	end,
}
