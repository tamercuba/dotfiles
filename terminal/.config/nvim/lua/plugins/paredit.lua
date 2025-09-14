return {
	{
		"julienvincent/nvim-paredit",
		ft = { "clojure", "fennel", "scheme" },
		config = function()
			local paredit = require("nvim-paredit")
			paredit.setup({
				keys = {
					[">)"] = false,
					["<)"] = false,
					[">("] = false,
					["<("] = false,
					["<localleader>o"] = false,

					-- CORE EDITING (your essentials)
					["<localleader>s"] = { paredit.api.slurp_forwards, "Slurp forwards" },
					["<localleader>b"] = { paredit.api.barf_forwards, "Barf forwards" },
					["<localleader>r"] = { paredit.api.raise_form, "Raise form" },
					["<localleader>@"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice" },

					-- STRUCTURAL NAVIGATION (new!)
					["<localleader>j"] = { paredit.api.move_to_next_element, "Next element" },
					["<localleader>k"] = { paredit.api.move_to_prev_element, "Prev element" },
					["<localleader>l"] = { paredit.api.move_to_next_element_tail, "Next form end" },
					["<localleader>h"] = { paredit.api.move_to_prev_element_tail, "Prev form end" },
					["<localleader>u"] = { paredit.api.move_to_parent_form_start, "Parent form start" },
					["<localleader>d"] = { paredit.api.move_to_parent_form_end, "Parent form end" },

					-- TODO
					-- ["<localleader>S"] = { paredit.api.slurp_backwards, "Slurp backwards" },
					-- ["<localleader>B"] = { paredit.api.barf_backwards, "Barf backwards" },
					-- ["<localleader>e"] = { paredit.api.drag_element_forwards, "Move element right" },
					-- ["<localleader>E"] = { paredit.api.drag_element_backwards, "Move element left" },
					-- ["<localleader>f"] = { paredit.api.drag_form_forwards, "Move form right" },
					-- ["<localleader>F"] = { paredit.api.drag_form_backwards, "Move form left" },
					cursor_behaviour = "auto", -- "remain", "follow", "auto"
					indent = {
						enabled = true,
						indentor = require("nvim-paredit.indentation.native").indentor,
					},
					dragging = {
						auto_drag_pairs = true,
					},
				},
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			return require("nvim-surround").setup()
		end,
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
