-- [nfnl] fnl/plugins/oil.fnl
return {"stevearc/oil.nvim", dependencies = {{"nvim-mini/mini.icons", opts = {}}}, opts = {view_options = {show_hidden = true}}, lazy = false, keys = { {"<leader>m", "<cmd>Oil<cr>", desc = "Open Oil at current file"}, {"<leader>M", "<cmd>Oil .<cr>", desc = "Open Oil in working directory"} }}
