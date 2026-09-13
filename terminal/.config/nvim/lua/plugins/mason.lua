-- [nfnl] fnl/plugins/mason.fnl
local function _1_()
  local mason = require("mason")
  return mason.setup()
end
return {"williamboman/mason.nvim", config = _1_}
