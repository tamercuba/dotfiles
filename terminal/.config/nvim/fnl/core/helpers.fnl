(fn assoc [tbl key value]
  (vim.tbl_extend :force tbl {key value}))

{: assoc}
