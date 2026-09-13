(fn open-jar-entry [buf jar entry]
  (let [content (vim.fn.system [:unzip :-p jar entry])]
    (when (= vim.v.shell_error 0)
      (let [lines (vim.split content "\n" {:trimempty false})
            bo (. vim.bo buf)]
        (vim.api.nvim_buf_set_lines buf 0 -1 false lines)
        (set bo.modifiable false)
        (set bo.buftype :nofile)
        (set bo.readonly true)
        (vim.schedule (fn [] (vim.cmd "filetype detect")))))))

(fn zipfile-jar-entry [name]
  (let [path (name:gsub "^zipfile://" "")]
    (path:match "^(.-)::(.+)$")))

(fn open-zipfile [ev]
  (let [name (vim.api.nvim_buf_get_name ev.buf)
        (jar entry) (zipfile-jar-entry name)]
    (when (and jar entry)
      (open-jar-entry ev.buf jar entry))))

(fn jarfile-jar-entry [name]
  (name:match "^jar:file://(.-)!/(.+)$"))

(fn open-jarfile [ev]
  (let [name (vim.api.nvim_buf_get_name ev.buf)
        (jar entry) (jarfile-jar-entry name)]
    (when (and jar entry)
      (open-jar-entry ev.buf jar entry))))

(vim.api.nvim_create_autocmd :BufReadCmd
                             {:pattern "zipfile://*" :callback open-zipfile})

(vim.api.nvim_create_autocmd :BufReadCmd
                             {:pattern "jar:file://*" :callback open-jarfile})
