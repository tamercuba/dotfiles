-- [nfnl] fnl/plugins/snacks.fnl
local exclude = {"node_modules", ".git", "*.lock", "target", ".clj-kondo", "**/lua/**/*.lua"}
local function find_files()
  return Snacks.picker.files({layout = {preset = "vertical", hidden = {"preview"}}})
end
local function find_grep()
  return Snacks.picker.grep()
end
local function find_buffers()
  return Snacks.picker.buffers()
end
local function find_help()
  return Snacks.picker.help()
end
local function find_reference()
  return Snacks.picker.lsp_reference()
end
local function find_diagnostics()
  return Snacks.picker.diagnostics()
end
local function find_git_status()
  return Snacks.picker.git_status()
end
local function find_lsp_implementation()
  return Snacks.picker.lsp_implementation()
end
local function find_git_unstaged()
  return Snacks.picker.git_diff({group = true})
end
return {"folke/snacks.nvim", priority = 1000, opts = {picker = {ui_select = true, sources = {files = {hidden = true, exclude = exclude}, grep = {hidden = true, exclude = exclude}}}}, keys = {{"<leader>ff", find_files, desc = "[F]ind [F]iles"}, {"<leader>fg", find_grep, desc = "[F]ind [G]rep"}, {"<leader>fb", find_buffers, desc = "[F]ind [B]uffers"}, {"<leader>fh", find_help, desc = "[F]ind [H]elp"}, {"<leader>fr", find_reference, desc = "[F]ind [R]eference"}, {"<leader>fd", find_diagnostics, desc = "[F]ind [D]iagnostics"}, {"<leader>fs", find_git_status, desc = "[F]ind git [S]tatus"}, {"<leader>fi", find_lsp_implementation, desc = "[F]ind lsp [I]mplementation"}, {"<leader>fu", find_git_unstaged, desc = "[F]ind git [U]nstaged"}}, lazy = false}
