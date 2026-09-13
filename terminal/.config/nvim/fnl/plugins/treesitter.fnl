(local parsers [:bash
                :c
                :clojure
                :html
                :javascript
                :typescript
                :tsx
                :json
                :lua
                :luadoc
                :luap
                :query
                :regex
                :vim
                :vimdoc
                :yaml
                :rust
                :go
                :gomod
                :gowork
                :gosum
                :nix
                :markdown
                :markdown_inline
                :dart
                :scala
                :fennel])

(local lisp-filetypes {:clojure true :fennel true :scheme true :risp true})

(fn on-filetype [ev]
  (let [ok (pcall vim.treesitter.start ev.buf)]
    (when (and ok (not (. lisp-filetypes ev.match)))
      (tset (. vim.bo ev.buf) :indentexpr
            "v:lua.require'nvim-treesitter'.indentexpr()"))))

(fn treesitter-config []
  (vim.treesitter.language.register :clojure :risp)
  (let [installed ((. (require :nvim-treesitter.config) :get_installed))
        to-install (-> (vim.iter parsers)
                       (: :filter (fn [p] (not (vim.tbl_contains installed p))))
                       (: :totable))]
    (when (> (length to-install) 0)
      ((. (require :nvim-treesitter) :install) to-install)))
  (vim.api.nvim_create_autocmd :FileType {:callback on-filetype}))

(fn ts-node [name]
  (.. "@" name))

(fn textobjects-config []
  (let [ts (require :nvim-treesitter-textobjects)]
    (ts.setup {:select {:lookahead true
                        :include_surrounding_whitespace false
                        :selection_modes {(ts-node :parameter.outer) :v
                                          (ts-node :parameter.inner) :v
                                          (ts-node :function.outer) :v
                                          (ts-node :conditional.outer) :V
                                          (ts-node :loop.outer) :V
                                          (ts-node :class.outer) :<c-v>}}
               :move {:set_jumps true}})
    (let [select-to (. (require :nvim-treesitter-textobjects.select)
                       :select_textobject)
          move (require :nvim-treesitter-textobjects.move)
          swap (require :nvim-treesitter-textobjects.swap)
          select-maps {:af (ts-node :function.outer)
                       :if (ts-node :function.inner)
                       :ac (ts-node :class.outer)
                       :ic (ts-node :class.inner)
                       :ai (ts-node :conditional.outer)
                       :ii (ts-node :conditional.inner)
                       :al (ts-node :loop.outer)
                       :il (ts-node :loop.inner)
                       :ap (ts-node :parameter.outer)
                       :ip (ts-node :parameter.inner)}
          move-maps {"]f" {:fn move.goto_next_start
                           :query (ts-node :function.outer)}
                     "]c" {:fn move.goto_next_start
                           :query (ts-node :class.outer)}
                     "]p" {:fn move.goto_next_start
                           :query (ts-node :parameter.inner)}
                     "[f" {:fn move.goto_previous_start
                           :query (ts-node :function.outer)}
                     "[c" {:fn move.goto_previous_start
                           :query (ts-node :class.outer)}
                     "[p" {:fn move.goto_previous_start
                           :query (ts-node :parameter.inner)}}]
      (each [key query (pairs select-maps)]
        (vim.keymap.set [:x :o] key (fn [] (select-to query :textobjects))))
      (each [key map (pairs move-maps)]
        (vim.keymap.set [:n :x :o] key (fn [] (map.fn map.query :textobjects))))
      (vim.keymap.set :n :<leader>sn
                      (fn [] (swap.swap_next (ts-node :parameter.inner)))
                      {:desc "Swap next parameter"})
      (vim.keymap.set :n :<leader>sp
                      (fn [] (swap.swap_previous (ts-node :parameter.inner)))
                      {:desc "Swap previous parameter"}))))

[{1 :nvim-treesitter/nvim-treesitter
  :branch :main
  :lazy false
  :build ":TSUpdate"
  :config treesitter-config}
 {1 :nvim-treesitter/nvim-treesitter-textobjects
  :branch :main
  :lazy false
  :config textobjects-config}]
