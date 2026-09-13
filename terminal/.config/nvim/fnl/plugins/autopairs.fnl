(fn config []
  (let [ap (require :nvim-autopairs)]
    (ap.setup {:check_ts true
               :ts_config {:lua [:string]
                           :javascript [:template_string]
                           :java false}
               :disable_filetype [:clojure :fennel :scheme :risp]})))

{1 :windwp/nvim-autopairs :event :InsertEnter : config}
