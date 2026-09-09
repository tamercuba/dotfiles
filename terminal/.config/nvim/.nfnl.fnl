(local config (require :nfnl.config))
(local default (config.default))
(local fs (require :nfnl.fs))

(fn fnl-path->lua-path [fnl-path]
  (let [lua-path (fs.replace-extension fnl-path :lua)]
    (if (lua-path:find :/fnl/after/)
        (lua-path:gsub :/fnl/after/ :/after/)
        (default.fnl-path->lua-path fnl-path))))

{:source-file-patterns [:fnl/**/*.fnl] : fnl-path->lua-path}
