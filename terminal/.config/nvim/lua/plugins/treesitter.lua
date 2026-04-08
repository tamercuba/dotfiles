return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			vim.treesitter.language.register("clojure", "risp")

			require("nvim-treesitter").setup({
				ensure_installed = {
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
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						include_surrounding_whitespace = false,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "around a function" },
							["if"] = { query = "@function.inner", desc = "inner part of a function" },
							["ac"] = { query = "@class.outer", desc = "around a class" },
							["ic"] = { query = "@class.inner", desc = "inner part of a class" },
							["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
							["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
							["al"] = { query = "@loop.outer", desc = "around a loop" },
							["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
							["ap"] = { query = "@parameter.outer", desc = "around parameter" },
							["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
						},
						selection_modes = {
							["@parameter.outer"] = "v",
							["@parameter.inner"] = "v",
							["@function.outer"] = "v",
							["@conditional.outer"] = "V",
							["@loop.outer"] = "V",
							["@class.outer"] = "<c-v>",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = { query = "@function.outer", desc = "Next function" },
							["]c"] = { query = "@class.outer", desc = "Next class" },
							["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
						},
						goto_previous_start = {
							["[f"] = { query = "@function.outer", desc = "Previous function" },
							["[c"] = { query = "@class.outer", desc = "Previous class" },
							["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>sn"] = { query = "@parameter.inner", desc = "Swap next parameter" },
						},
						swap_previous = {
							["<leader>sp"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
						},
					},
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local ok = pcall(vim.treesitter.start, ev.buf)
					if ok then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
}
