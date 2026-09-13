(local opts {:noremap true :silent true})

;; New file

(fn buf-not-saved-warning []
  (vim.notify "Este buffer não está associado a um arquivo salvo."
              vim.log.levels.WARN))

(fn create-empty-file [path]
  (let [uv vim.loop
        fd (uv.fs_open path :w 420)]
    (if fd
        (do
          (uv.fs_close fd) true)
        (do
          (vim.notify (.. "Erro ao criar o arquivo: " path)
                      vim.log.levels.ERROR)
          false))))

(fn open-file [path]
  (vim.cmd (.. "edit " (vim.fn.fnameescape path))))

(fn create-and-open-file [dir input]
  (when (and input (not= input ""))
    (let [new-path (.. dir "/" input)]
      (when (create-empty-file new-path)
        (open-file new-path)))))

(fn new-file []
  (let [current-path (vim.api.nvim_buf_get_name 0)]
    (if (= current-path "")
        (buf-not-saved-warning)
        (let [current-dir (vim.fn.fnamemodify current-path ":h")]
          (vim.ui.input {:prompt "Nome do novo arquivo: " :completion :file}
                        (fn [input] (create-and-open-file current-dir input)))))))

;; Window resize

(fn resize [command sign amount]
  (vim.cmd (.. command " " sign amount)))

(fn resize-by [command sign step]
  (resize command sign (* step vim.v.count1)))

(fn increase-window-width []
  (resize-by "vertical resize" "-" 5))

(fn decrease-window-width []
  (resize-by "vertical resize" "+" 5))

(fn increase-window-height []
  (resize-by :resize "+" 3))

(fn decrease-window-height []
  (resize-by :resize "-" 3))

;; Diagnostics

(fn any-loclist-open? []
  (accumulate [found false _ win (ipairs (vim.fn.getwininfo))]
    (or found (= win.loclist 1))))

(fn toggle-diagnostics []
  (if (any-loclist-open?)
      (vim.cmd :lclose)
      (vim.diagnostic.setloclist)))

;; Clojure/Conjure helpers

(fn first-line []
  (or (. (vim.api.nvim_buf_get_lines 0 0 1 false) 1) ""))

(fn namespace-name [line]
  (line:match "^%s*%(ns%s+([%w%.%-]+)"))

(fn reload-namespace []
  (let [ns-name (namespace-name (first-line))]
    (if ns-name
        (vim.cmd (.. "ConjureEval (require '" ns-name " :reload-all)"))
        (vim.notify "Namespace não encontrado na primeira linha"
                    vim.log.levels.WARN))))

(fn restart-repl []
  (vim.fn.system "pkill -f lein")
  (vim.fn.jobstart "lein repl" {:detach true}))

(fn select-shadow-build []
  (vim.ui.input {:prompt "Shadow-cljs build: "}
                (fn [input]
                  (when (and input (not= input ""))
                    (vim.cmd (.. "ConjureShadowSelect " input))))))

;; Simple keymaps

(local simple-keymaps [[:n :n :nzzzv]
                       [:n :N :Nzzzv]
                       [:v "<" :<gv opts]
                       [:v ">" :>gv opts]
                       [:n :x "\"_x" opts]])

(each [_ [mode lhs rhs kopts] (ipairs simple-keymaps)]
  (vim.keymap.set mode lhs rhs kopts))

(local window-nav-keymaps
       [[:<c-l> ":wincmd l<CR>" "Go to right table"]
        [:<c-h> ":wincmd h<CR>" "Go to left table"]
        [:<c-j> ":wincmd j<CR>" "Go to upper table"]
        [:<c-k> ":wincmd k<CR>" "Go to bottom table"]])

(each [_ [lhs rhs desc] (ipairs window-nav-keymaps)]
  (vim.keymap.set :n lhs rhs {: desc}))

(vim.keymap.set :n :<leader>fn new-file
                {:desc "[N]ew [F]ile" :noremap true :silent true})

(vim.keymap.set :n :<leader>pn ":vsplit<CR>"
                {:desc "New vertical panel" :noremap true :silent true})

(vim.keymap.set :n :<leader>ph ":split<CR>"
                {:desc "New horizontal panel" :noremap true :silent true})

(vim.keymap.set :n :<Leader>prl increase-window-width
                {:desc "Increase window width"})

(vim.keymap.set :n :<Leader>prh decrease-window-width
                {:desc "Decrease window width"})

(vim.keymap.set :n :<Leader>prk increase-window-height
                {:desc "Increase window height"})

(vim.keymap.set :n :<Leader>prj decrease-window-height
                {:desc "Decrease window height"})

(vim.api.nvim_set_keymap :t :<C-k> "<C-\\><C-n><C-w>k"
                         {:noremap true :silent true})

(vim.api.nvim_set_keymap :t :<C-j> "<C-\\><C-n><C-w>j"
                         {:noremap true :silent true})

(vim.keymap.set :v :J ":m '>+1<CR>gv=gv"
                {:desc "moves lines down in visual selection"})

(vim.keymap.set :v :K ":m '<-2<CR>gv=gv"
                {:desc "moves lines up in visual selection"})

(vim.keymap.set :n :<leader>d toggle-diagnostics
                {:desc "Toggle diagnostics (buffer)"})

(vim.keymap.set :n :<leader>s
                ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"
                {:desc "Replace word cursor is on globally"
                 :noremap true
                 :silent false})

(vim.keymap.set :n :<localleader>rn reload-namespace
                {:desc "Reload namespace and all deps"
                 :noremap true
                 :silent true})

(vim.keymap.set :n :<localleader>rp restart-repl
                {:desc "Kill lein processes, start new REPL "
                 :noremap true
                 :silent true})

(vim.keymap.set :n :<localleader>cj select-shadow-build
                {:desc "Select shadow-cljs build" :noremap true :silent true})
