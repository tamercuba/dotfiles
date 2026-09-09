(local lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim))
(local uv (or vim.uv vim.loop))

(when (not (uv.fs_stat lazypath))
  (let [lazyrepo "https://github.com/folke/lazy.nvim.git"
        out (vim.fn.system [:git
                            :clone
                            "--filter=blob:none"
                            :--branch=stable
                            lazyrepo
                            lazypath])]
    (when (not= vim.v.shell_error 0)
      (error (.. "Error cloning lazy.nvim:\n" out)))))

(vim.opt.rtp:prepend lazypath)

(local lazy (require :lazy))
(lazy.setup {:import :plugins}
            {:install {:missing true :colorscheme [:habamax]}
             :checker {:enabled true :notify false}
             :change_detection {:enabled true :notify false}
             :ui {:border :rounded}
             :performance {:rtp {:disabled_plugins [:gzip
                                                    :tarPlugin
                                                    :tohtml
                                                    :tutor
                                                    :zipPlugin]}}})
