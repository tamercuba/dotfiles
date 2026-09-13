-- [nfnl] fnl/config/trust.fnl
local trust_path = (vim.fn.stdpath("config") .. "/.nfnl.fnl")
local function trust_nfnl_config()
  return vim.secure.trust({action = "allow", path = trust_path})
end
trust_nfnl_config()
return vim.api.nvim_create_autocmd("BufWritePost", {group = vim.api.nvim_create_augroup("nfnl-trust", {clear = true}), pattern = ".nfnl.fnl", callback = trust_nfnl_config})
