-- [nfnl] fnl/plugins/treesitter.fnl
local parsers = {"bash", "c", "clojure", "html", "javascript", "typescript", "tsx", "json", "lua", "luadoc", "luap", "query", "regex", "vim", "vimdoc", "yaml", "rust", "go", "gomod", "gowork", "gosum", "nix", "markdown", "markdown_inline", "dart", "scala", "fennel"}
local lisp_filetypes = {clojure = true, fennel = true, scheme = true, risp = true}
local function on_filetype(ev)
  local ok = pcall(vim.treesitter.start, ev.buf)
  if (ok and not lisp_filetypes[ev.match]) then
    vim.bo[ev.buf]["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
    return nil
  else
    return nil
  end
end
local function treesitter_config()
  vim.treesitter.language.register("clojure", "risp")
  do
    local installed = require("nvim-treesitter.config").get_installed()
    local to_install
    local function _2_(p)
      return not vim.tbl_contains(installed, p)
    end
    to_install = vim.iter(parsers):filter(_2_):totable()
    if (#to_install > 0) then
      require("nvim-treesitter").install(to_install)
    else
    end
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = on_filetype})
end
local function ts_node(name)
  return ("@" .. name)
end
local function textobjects_config()
  local ts = require("nvim-treesitter-textobjects")
  ts.setup({select = {lookahead = true, selection_modes = {[ts_node("parameter.outer")] = "v", [ts_node("parameter.inner")] = "v", [ts_node("function.outer")] = "v", [ts_node("conditional.outer")] = "V", [ts_node("loop.outer")] = "V", [ts_node("class.outer")] = "<c-v>"}, include_surrounding_whitespace = false}, move = {set_jumps = true}})
  local select_to = require("nvim-treesitter-textobjects.select").select_textobject
  local move = require("nvim-treesitter-textobjects.move")
  local swap = require("nvim-treesitter-textobjects.swap")
  local select_maps = {af = ts_node("function.outer"), ["if"] = ts_node("function.inner"), ac = ts_node("class.outer"), ic = ts_node("class.inner"), ai = ts_node("conditional.outer"), ii = ts_node("conditional.inner"), al = ts_node("loop.outer"), il = ts_node("loop.inner"), ap = ts_node("parameter.outer"), ip = ts_node("parameter.inner")}
  local move_maps = {["]f"] = {fn = move.goto_next_start, query = ts_node("function.outer")}, ["]c"] = {fn = move.goto_next_start, query = ts_node("class.outer")}, ["]p"] = {fn = move.goto_next_start, query = ts_node("parameter.inner")}, ["[f"] = {fn = move.goto_previous_start, query = ts_node("function.outer")}, ["[c"] = {fn = move.goto_previous_start, query = ts_node("class.outer")}, ["[p"] = {fn = move.goto_previous_start, query = ts_node("parameter.inner")}}
  for key, query in pairs(select_maps) do
    local function _4_()
      return select_to(query, "textobjects")
    end
    vim.keymap.set({"x", "o"}, key, _4_)
  end
  for key, map in pairs(move_maps) do
    local function _5_()
      return map.fn(map.query, "textobjects")
    end
    vim.keymap.set({"n", "x", "o"}, key, _5_)
  end
  local function _6_()
    return swap.swap_next(ts_node("parameter.inner"))
  end
  vim.keymap.set("n", "<leader>sn", _6_, {desc = "Swap next parameter"})
  local function _7_()
    return swap.swap_previous(ts_node("parameter.inner"))
  end
  return vim.keymap.set("n", "<leader>sp", _7_, {desc = "Swap previous parameter"})
end
return {{"nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate", config = treesitter_config, lazy = false}, {"nvim-treesitter/nvim-treesitter-textobjects", branch = "main", config = textobjects_config, lazy = false}}
