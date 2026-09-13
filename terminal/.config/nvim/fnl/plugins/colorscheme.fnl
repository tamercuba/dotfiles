(fn config [_ opts]
  (let [gm-label :gruvbox-material
        gm (require gm-label)
        diff-bg "#1d3520"]
    (gm.setup opts)
    (vim.cmd.colorscheme gm-label)
    (vim.api.nvim_set_hl 0 :NormalFloat {:bg "#282828"})
    (vim.api.nvim_set_hl 0 :FloatBorder {:fg "#665c54" :bg "#282828"})
    (each [_ group (ipairs [:DiffAdd :DiffChange :DiffText])]
      (vim.api.nvim_set_hl 0 group {:bg diff-bg}))
    (vim.api.nvim_set_hl 0 :DiffDelete {:bg "#3d1a1a"})))

{1 :f4z3r/gruvbox-material.nvim
 :name :gruvbox-material
 :lazy false
 :priority 1000
 :opts {:contrast :hard :background {:transparent true}}
 : config}
