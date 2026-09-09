(fn config []
  (let [ls (require :luasnip)]
    (ls.add_snippets :go
                     [(ls.snippet :iferr
                                  [(ls.text_node ["if err != nil {"
                                                  "\treturn "])
                                   (ls.insert_node 1 :nil)
                                   (ls.text_node [", err" "}"])])])
    ((. (require :luasnip.loaders.from_vscode) :lazy_load))))

{1 :L3MON4D3/LuaSnip : config}
