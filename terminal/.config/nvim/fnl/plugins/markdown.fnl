(fn build []
  (let [lazy (require :lazy)]
    (lazy.load {:plugins [:markdown-preview.nvim]})
    ((. vim.fn "mkdp#util#install"))))

{1 :iamcco/markdown-preview.nvim
 :cmd [:MarkdownPreviewToggle :MarkdownPreview :MarkdownPreviewStop]
 :ft :markdown
 :keys [{1 :<leader>pm
         2 :<cmd>MarkdownPreviewToggle<cr>
         :ft :markdown
         :desc "Markdown Preview"}]
 : build}
