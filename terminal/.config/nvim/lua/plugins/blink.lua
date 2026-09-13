-- [nfnl] fnl/plugins/blink.fnl
local h = require("core.helpers")
local function transform_items(_, items)
  local tbl_26_ = {}
  local i_27_ = 0
  for _0, item in ipairs(items) do
    local val_28_
    if item.label then
      val_28_ = item
    else
      val_28_ = h.assoc(item, "label", (item.insertText or item.filterText or "?"))
    end
    if (nil ~= val_28_) then
      i_27_ = (i_27_ + 1)
      tbl_26_[i_27_] = val_28_
    else
    end
  end
  return tbl_26_
end
return {{"saghen/blink.compat", version = "*", lazy = true}, {"saghen/blink.cmp", version = "*", dependencies = {"rafamadriz/friendly-snippets", "PaterJason/cmp-conjure", "mikavilpas/blink-ripgrep.nvim", "L3MON4D3/LuaSnip"}, opts = {keymap = {keymap = {["<C-j>"] = {"select_next", "fallback"}, ["<C-k>"] = {"select_prev", "fallback"}, ["<CR>"] = {"accept", "fallback"}, ["<Tab>"] = {"snippet_forward", "select_next", "fallback"}, ["<S-Tab>"] = {"snippet_backward", "select_prev", "fallback"}, ["<C-f>"] = {}, ["<Up>"] = {"select_prev", "fallback"}, ["<Down>"] = {"select_next", "fallback"}}}, cmdline = {completion = {menu = {auto_show = true}}, keymap = {["<CR>"] = {accept_and_enter = "fallback"}}, enabled = false}, completion = {accept = {auto_brackets = {enabled = true}}, menu = {border = nil, scrolloff = 1, draw = {columns = {{"kind_icon"}, {"label", "label_description", gap = 1}, {"kind"}, {"source_name"}}}, scrollbar = false}, documentation = {window = {border = nil, winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc", scrollbar = false}, auto_show = true, auto_show_delay_ms = 500}}, appearance = {use_nvim_cmp_as_default = true, nerd_font_variant = "mono"}, snippets = {preset = "luasnip"}, sources = {default = {"lsp", "path", "snippets", "buffer", "conjure"}, transform_items = transform_items, providers = {conjure = {name = "conjure", module = "blink.compat.source", score_offset = -3}}}}, lazy = false}}
