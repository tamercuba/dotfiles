(fn new-clj-file? [buf]
  (<= (vim.api.nvim_buf_line_count buf) 1))

(fn project-root [dir]
  (let [marker (. (vim.fs.find [:deps.edn :project.clj]
                               {:upward true :path dir :type :file})
                  1)]
    (when marker
      (vim.fs.dirname marker))))

(fn relative-subpath [rel]
  (or (rel:match "^src/clj[sc]?/(.+)") (rel:match "^test/clj[sc]?/(.+)")
      (rel:match "^src/(.+)") (rel:match "^test/(.+)")))

(fn clj-namespace [root file]
  (let [rel (file:sub (+ (length root) 2))
        subpath (relative-subpath rel)]
    (when (and subpath (subpath:match "%.clj$"))
      (let [trimmed (subpath:gsub "%.clj$" "")
            slashed (trimmed:gsub "/" ".")
            dashed (slashed:gsub "_" "-")
            ns (dashed:gsub "^%.*" "")]
        (when (not= ns "")
          ns)))))

(fn empty-buffer? [buf]
  (let [existing (. (vim.api.nvim_buf_get_lines buf 0 1 false) 1)]
    (or (= existing nil) (= existing ""))))

(fn write-namespace! [buf ns]
  (vim.api.nvim_buf_set_lines buf 0 -1 false [(.. "(ns " ns ")") ""])
  (vim.api.nvim_buf_set_mark buf :n 1 1 {}))

(fn insert-clojure-ns-if-needed [args]
  (let [buf args.buf
        file (vim.api.nvim_buf_get_name buf)]
    (when (and (new-clj-file? buf) (not= file ""))
      (let [root (project-root (vim.fs.dirname file))]
        (when root
          (let [ns (clj-namespace root file)]
            (when (and ns (empty-buffer? buf))
              (write-namespace! buf ns))))))))

(vim.api.nvim_create_autocmd [:BufNewFile :BufRead]
                             {:pattern :*.clj
                              :callback insert-clojure-ns-if-needed})

(fn trim-trailing-blank-lines []
  (let [total-lines (vim.api.nvim_buf_line_count 0)
        last-nonblank (vim.fn.prevnonblank total-lines)]
    (when (< last-nonblank (- total-lines 1))
      (vim.api.nvim_buf_set_lines 0 (+ last-nonblank 1) total-lines false []))))

(vim.api.nvim_create_autocmd :BufWritePre
                             {:pattern [:*.clj :*.cljs :*.cljc :*.edn]
                              :callback trim-trailing-blank-lines})

(vim.filetype.add {:extension {:risp :risp}})

(fn shebang-clojure? [_ bufnr]
  (let [first-line (or (. (vim.api.nvim_buf_get_lines bufnr 0 1 false) 1) "")]
    (when (first-line:match "^#!/usr/bin/env bb") :clojure)))

(vim.filetype.add {:pattern {:.* shebang-clojure?}})

(vim.api.nvim_create_user_command :ConjureGo (fn [] (vim.cmd :ConjureConnect))
                                  {:desc "Conecta o Conjure ao REPL"})

(fn resize-conjure-log []
  (vim.cmd (.. "vertical resize " (math.floor (* 0.3 vim.o.columns)))))

(vim.api.nvim_create_autocmd :BufWinEnter
                             {:pattern [:conjure-log-*]
                              :callback resize-conjure-log})
