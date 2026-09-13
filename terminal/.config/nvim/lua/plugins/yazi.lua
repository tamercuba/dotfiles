-- [nfnl] fnl/plugins/yazi.fnl
return {"mikavilpas/yazi.nvim", event = "VeryLazy", dependencies = {"nvim-lua/plenary.nvim"}, keys = {{"<leader>m", "<cmd>Yazi<cr>", desc = "Open Yazi at current file"}, {"<leader>M", "<cmd>Yazi cwd<cr>", desc = "Open Yazi in project root"}}, opts = {open_for_directories = true}}
