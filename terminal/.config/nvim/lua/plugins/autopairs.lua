-- [nfnl] fnl/plugins/autopairs.fnl
local function config()
  local ap = require("nvim-autopairs")
  return ap.setup({check_ts = true, ts_config = {lua = {"string"}, javascript = {"template_string"}, java = false}, disable_filetype = {"clojure", "fennel", "scheme", "risp"}})
end
return {"windwp/nvim-autopairs", event = "InsertEnter", config = config}
