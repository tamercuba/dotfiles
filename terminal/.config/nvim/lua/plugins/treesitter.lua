local parsers = {
	"bash", "c", "clojure", "html", "javascript", "typescript", "tsx",
	"json", "lua", "luadoc", "luap", "query", "regex", "vim", "vimdoc",
	"yaml", "rust", "go", "gomod", "gowork", "gosum", "nix", "markdown",
	"markdown_inline",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.treesitter.language.register("clojure", "risp")

			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(parsers)
				:filter(function(p) return not vim.tbl_contains(installed, p) end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

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
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		config = function()
			local ts = require("nvim-treesitter-textobjects")
			ts.setup({
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

			local select_to = require("nvim-treesitter-textobjects.select").select_textobject
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			local select_maps = {
				["af"] = "@function.outer", ["if"] = "@function.inner",
				["ac"] = "@class.outer", ["ic"] = "@class.inner",
				["ai"] = "@conditional.outer", ["ii"] = "@conditional.inner",
				["al"] = "@loop.outer", ["il"] = "@loop.inner",
				["ap"] = "@parameter.outer", ["ip"] = "@parameter.inner",
			}
			for key, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function() select_to(query, "textobjects") end)
			end

			local move_maps = {
				["]f"] = { fn = move.goto_next_start, query = "@function.outer" },
				["]c"] = { fn = move.goto_next_start, query = "@class.outer" },
				["]p"] = { fn = move.goto_next_start, query = "@parameter.inner" },
				["[f"] = { fn = move.goto_previous_start, query = "@function.outer" },
				["[c"] = { fn = move.goto_previous_start, query = "@class.outer" },
				["[p"] = { fn = move.goto_previous_start, query = "@parameter.inner" },
			}
			for key, map in pairs(move_maps) do
				vim.keymap.set({ "n", "x", "o" }, key, function() map.fn(map.query, "textobjects") end)
			end

			vim.keymap.set("n", "<leader>sn", function() swap.swap_next("@parameter.inner") end, { desc = "Swap next parameter" })
			vim.keymap.set("n", "<leader>sp", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap previous parameter" })
		end,
	},
}
