(fn filename-with-path []
  (let [relpath (vim.fn.expand "%:.")
        filename (vim.fn.expand "%:t")
        dir (vim.fn.fnamemodify relpath ":h")]
    (if (= dir ".")
        filename
        (.. dir "/" filename))))

(fn config []
  (let [ll (require :lualine)]
    (ll.setup {:options {:theme :gruvbox-material}
               :sections {:lualine_c [filename-with-path]}})))

{1 :nvim-lualine/lualine.nvim
 :dependencies [:nvim-tree/nvim-web-devicons]
 : config}
