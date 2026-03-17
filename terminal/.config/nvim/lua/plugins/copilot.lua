-- Copilot is only enabled on the personal machine (host "tamer.cuba").
-- On any other host the plugin is not loaded at all.
local is_personal_host = vim.fn.getenv("HOST") == "tamer.cuba"

return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	enabled = is_personal_host,
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<Tab>", -- Tab aceita Copilot
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
		})

		vim.keymap.set("n", "<leader>gc", function()
			require("copilot.suggestion").toggle_auto_trigger()
		end, { desc = "Toggle [G]ithub [C]opilot" })
	end,
}
