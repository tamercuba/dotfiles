-- [nfnl] fnl/config/clojure.fnl
vim.g["conjure#filetype#risp"] = "conjure.client.clojure.nrepl"
vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = true
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
vim.g["conjure#client#clojure#nrepl#eval#pretty_print"] = true
vim.g["conjure#client#clojure#nrepl#connection#port_files"] = {".nrepl-port", "modules/**/.nrepl-port"}
vim.g["conjure#extract#tree_sitter#enabled"] = true
vim.g["conjure#client#clojure#nrepl#test#runner"] = "clojure"
vim.g["conjure#completion#enabled"] = true
vim.g["conjure#completion#omnifunc"] = "v:lua.require'blink.cmp'.omnifunc"
vim.g["conjure#mapping#doc_word"] = "gK"
vim.g["conjure#log#hud#enabled"] = false
vim.g["conjure#mapping#log_vsplit"] = false
vim.g["conjure#mapping#log_tab"] = false
vim.g["conjure#client#clojure#nrepl#refresh#backend"] = "clojure.tools.namespace"
vim.g["conjure#client#clojure#nrepl#refresh#before"] = nil
vim.g["conjure#client#clojure#nrepl#refresh#after"] = nil
vim.g["conjure#mapping#session_select"] = false
vim.g["conjure#mapping#session_prev"] = false
vim.g["conjure#mapping#session_next"] = false
vim.g["conjure#mapping#session_list"] = false
vim.g["conjure#mapping#session_close"] = false
vim.g["conjure#mapping#session_close_all"] = false
vim.g["conjure#mapping#session_fresh"] = false
vim.g["conjure#mapping#session_clone"] = false
vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = {"deftest", "defflow", "defflow-i18n", "defspec", "facts"}
local function callback()
  return vim.cmd(("vertical resize " .. math.floor((0.3 * vim.o.columns))))
end
return vim.api.nvim_create_autocmd("BufWinEnter", {pattern = {"conjure-log-*"}, callback = callback})
