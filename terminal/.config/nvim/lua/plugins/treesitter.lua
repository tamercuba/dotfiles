return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local ok = pcall(vim.treesitter.start, ev.buf)
					if ok then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			require("nvim-treesitter").install({
				"bash",
				"c",
				"clojure",
				"html",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"lua",
				"luadoc",
				"luap",
				"query",
				"regex",
				"vim",
				"vimdoc",
				"yaml",
				"rust",
				"go",
				"gomod",
				"gowork",
				"gosum",
			"nix",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = false,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@parameter.inner"] = "v",
						["@function.outer"] = "v",
						["@conditional.outer"] = "V",
						["@loop.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
				},
				move = { set_jumps = true },
			})

			local sel = require("nvim-treesitter-textobjects.select")
			local mov = require("nvim-treesitter-textobjects.move")
			local swp = require("nvim-treesitter-textobjects.swap")

			-- Text object selections
			local sel_maps = {
				["af"] = { "@function.outer", "around a function" },
				["if"] = { "@function.inner", "inner part of a function" },
				["ac"] = { "@class.outer", "around a class" },
				["ic"] = { "@class.inner", "inner part of a class" },
				["ai"] = { "@conditional.outer", "around an if statement" },
				["ii"] = { "@conditional.inner", "inner part of an if statement" },
				["al"] = { "@loop.outer", "around a loop" },
				["il"] = { "@loop.inner", "inner part of a loop" },
				["ap"] = { "@parameter.outer", "around parameter" },
				["ip"] = { "@parameter.inner", "inside a parameter" },
			}
			for key, val in pairs(sel_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					sel.select_textobject(val[1], "textobjects")
				end, { desc = val[2] })
			end

			-- Navigation
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				mov.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Previous function" })
			vim.keymap.set({ "n", "x", "o" }, "[c", function()
				mov.goto_previous_start("@class.outer", "textobjects")
			end, { desc = "Previous class" })
			vim.keymap.set({ "n", "x", "o" }, "[p", function()
				mov.goto_previous_start("@parameter.inner", "textobjects")
			end, { desc = "Previous parameter" })
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				mov.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function" })
			vim.keymap.set({ "n", "x", "o" }, "]c", function()
				mov.goto_next_start("@class.outer", "textobjects")
			end, { desc = "Next class" })
			vim.keymap.set({ "n", "x", "o" }, "]p", function()
				mov.goto_next_start("@parameter.inner", "textobjects")
			end, { desc = "Next parameter" })

			-- Swap parameters
			vim.keymap.set("n", "<leader>sn", function()
				swp.swap_next("@parameter.inner")
			end, { desc = "Swap next parameter" })
			vim.keymap.set("n", "<leader>sp", function()
				swp.swap_previous("@parameter.inner")
			end, { desc = "Swap previous parameter" })
		end,
	},
}
