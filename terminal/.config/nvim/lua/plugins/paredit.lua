return {
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "fennel", "scheme", "risp" },
    config = function()
      local paredit = require("nvim-paredit")
      paredit.setup({
        filetypes = { "clojure", "fennel", "scheme", "risp" },
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

            ["<localleader>n"] = {
              function()
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                local line = vim.api.nvim_get_current_line()
                local before = line:sub(1, col)
                local after = line:sub(col + 1)
                vim.api.nvim_set_current_line(before .. "()" .. after)
                vim.api.nvim_win_set_cursor(0, { row, col })
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