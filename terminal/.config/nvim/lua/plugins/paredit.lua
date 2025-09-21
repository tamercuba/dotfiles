return {
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "fennel", "scheme" },
    config = function()
      local paredit = require("nvim-paredit")
      paredit.setup({
        keys = {
          -- Slurps
          ["<localleader>ps"] = { paredit.api.slurp_forwards, "Slurp forwards" },
            ["<localleader>pS"] = { paredit.api.slurp_backwards, "Slurp backwards" },

            -- Barfs
            ["<localleader>pb"] = { paredit.api.barf_forwards, "Barf forwards" },
            ["<localleader>pB"] = { paredit.api.barf_backwards, "Barf backwards" },

            -- Select current form / content of current form
            ["<localleader>pf"] = {
              function()
                vim.cmd("normal! va(")
              end,
              "Select current form",
            },
            ["<localleader>pF"] = {
              function()
                vim.cmd("normal! vi(")
              end,
              "Select form content",
            },

            -- New empty form ()
            ["<localleader>pn"] = {
              function()
                local keys = vim.api.nvim_replace_termcodes("i()", true, false, true)
                vim.api.nvim_feedkeys(keys, "n", false)
                local left = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
                vim.api.nvim_feedkeys(left, "n", false)
              end,
              "New empty form",
            },

            -- Wrap current symbol with ()
            ["<localleader>pw"] = {
              function()
                vim.cmd("normal! ysiw(")
              end,
              "Wrap symbol with ()",
            },

            -- Wrap current form with ()
            ["<localleader>pW"] = {
              function()
                vim.cmd("normal! va(")
                local keys = vim.api.nvim_replace_termcodes("S(", true, false, true)
                vim.api.nvim_feedkeys(keys, "x", false)
              end,
              "Wrap form with ()",
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