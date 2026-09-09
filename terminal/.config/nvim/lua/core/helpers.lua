-- [nfnl] fnl/core/helpers.fnl
local function assoc(tbl, key, value)
  return vim.tbl_extend("force", tbl, {[key] = value})
end
return {assoc = assoc}
