-- [nfnl] fnl/plugins/alpha.fnl
local function config()
  local alpha = require("alpha")
  return alpha.setup(require("alpha.themes.dashboard").config)
end
return {"goolord/alpha-nvim", config = config}
