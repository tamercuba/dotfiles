;; Loading REPL configuration files

(fn repl-config-dir []
  (.. (vim.fn.stdpath :config) :/lua/config/repl_picker))

(fn repl-config-files []
  (vim.fn.glob (.. (repl-config-dir) :/*.repl.lua) false true))

(fn load-repl-file [path]
  (let [(ok result) (pcall dofile path)]
    (if (and ok (= (type result) :table))
        result
        (let [basename (path:match "([^/]+)$")]
          (vim.notify (string.format "Failed to load REPL config from %s: %s"
                                     basename (tostring result))
                      vim.log.levels.WARN)
          {}))))

(fn load-repl-configurations []
  (accumulate [merged {} _ path (ipairs (repl-config-files))]
    (vim.tbl_deep_extend :force merged (load-repl-file path))))

;; Locating the current project

(fn find-marker-upwards [marker from]
  (let [found (vim.fn.findfile marker (.. from ";"))]
    (when (not= found "")
      (vim.fn.fnamemodify found ":p:h"))))

(fn find-project-root []
  (let [from (vim.fn.expand "%:p:h")]
    (accumulate [root nil _ marker (ipairs [:project.clj :deps.edn :.git])]
      (or root (find-marker-upwards marker from)))))

;; Matching the project against configured REPLs

(fn projects-dir []
  (os.getenv :PROJECTS))

(fn strip-projects-dir [root pdir]
  (if pdir
      (let [stripped (root:gsub pdir "")] stripped)
      root))

(fn prefix-match [repls root]
  (accumulate [found nil candidate cfg (pairs repls)]
    (or found (when (root:find candidate 1 true) cfg))))

(fn project-repls-for [all-repls root]
  (when root
    (or (. all-repls root) (prefix-match all-repls root))))

(fn current-project-repls [all-repls]
  (let [raw-root (find-project-root)
        pdir (projects-dir)]
    (when raw-root
      (project-repls-for all-repls (strip-projects-dir raw-root pdir)))))

;; Building the picker's repl list

(fn default-repl-list [cwd]
  [{:display :Babashka :config {:command :bb-nrepl : cwd}}
   {:display :REPL :config {:command "lein repl" : cwd}}])

(fn repls-map->list [repls]
  (icollect [display config (pairs repls)]
    {: display : config}))

(fn sorted-by-display [list]
  (table.sort list (fn [a b] (< a.display b.display)))
  list)

(fn repl-list [all-repls cwd]
  (match (current-project-repls all-repls)
    nil (default-repl-list cwd)
    repls (sorted-by-display (repls-map->list repls))))

(fn picker-items [repls]
  (icollect [_ repl (ipairs repls)]
    {:text repl.display : repl}))

;; Starting the chosen REPL in tmux

(fn inside-tmux? []
  (vim.fn.system "tmux display-message -p '#{session_name}' 2>/dev/null")
  (= vim.v.shell_error 0))

(fn ensure-repl-session! []
  (vim.fn.system "tmux has-session -t REPL 2>/dev/null")
  (when (not= vim.v.shell_error 0)
    (vim.fn.system "tmux new-session -d -s REPL")
    (vim.notify "Created tmux session: REPL" vim.log.levels.INFO)))

(fn resolve-cwd [cwd pdir]
  (if (and pdir (not (cwd:match "^/")))
      (.. pdir cwd)
      cwd))

(fn window-name [display]
  (let [name (display:gsub " REPL$" "")] name))

(fn tmux-new-window-cmd [name full-command]
  (string.format "tmux new-window -t %s -n %s '%s'" (vim.fn.shellescape :REPL)
                 (vim.fn.shellescape name) full-command))

(fn start-repl-in-tmux! [display config]
  (if (not (inside-tmux?))
      (vim.notify "You must be inside a tmux session to use this feature"
                  vim.log.levels.ERROR)
      (do
        (ensure-repl-session!)
        (let [cwd (resolve-cwd config.cwd (projects-dir))
              full-command (string.format "cd %s && %s"
                                          (vim.fn.shellescape cwd)
                                          config.command)]
          (vim.fn.system (tmux-new-window-cmd (window-name display)
                                              full-command))
          (if (= vim.v.shell_error 0)
              (vim.notify (string.format "Started %s in tmux session 'REPL'"
                                         display)
                          vim.log.levels.INFO)
              (vim.notify (string.format "Failed to start %s" display)
                          vim.log.levels.ERROR))))))

;; Wiring the picker up

(fn confirm-repl [picker item]
  (picker:close)
  (when item
    (start-repl-in-tmux! item.repl.display item.repl.config)))

(fn format-repl-item [item]
  [[item.text]])

(fn select-and-start-repl [all-repls]
  (let [(has-snacks snacks) (pcall require :snacks)]
    (if (not has-snacks)
        (vim.notify "snacks.nvim is not installed" vim.log.levels.ERROR)
        (snacks.picker.pick {:title "REPL Picker"
                             :items (picker-items (repl-list all-repls
                                                             (or (find-project-root)
                                                                 (vim.fn.getcwd))))
                             :layout {:preset :select}
                             :format format-repl-item
                             :confirm confirm-repl}))))

(local all-repls (load-repl-configurations))

(vim.api.nvim_create_user_command :ReplPicker
                                  (fn [] (select-and-start-repl all-repls))
                                  {:desc "Open REPL picker to start a REPL in tmux"})

(vim.keymap.set :n :<localleader>mr (fn [] (select-and-start-repl all-repls))
                {:desc "Open REPL picker" :noremap true :silent true})
