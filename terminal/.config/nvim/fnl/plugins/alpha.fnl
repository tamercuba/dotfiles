(fn config []
  (let [alpha (require :alpha)]
    (-> (require :alpha.themes.dashboard)
        (. :config)
        (alpha.setup))))

{1 :goolord/alpha-nvim : config}
