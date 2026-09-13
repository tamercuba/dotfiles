(set vim.opt.list true)
(set vim.opt.listchars {:tab "» " :trail "·" :nbsp "␣"})
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ";")
(set vim.o.autoread true)
(set vim.wo.relativenumber true)

(set vim.opt.tabstop 2)
(set vim.opt.softtabstop 2)
(set vim.opt.shiftwidth 2)
(set vim.opt.expandtab true)
(set vim.opt.autoindent true)
(set vim.opt.smartindent true)
(set vim.opt.breakindent true)
(set vim.opt.wrap true)
(set vim.opt.linebreak true)
(set vim.opt.breakindent true)
(set vim.opt.breakindentopt ["shift:2" :sbr])
(set vim.opt.showbreak "↳ ")
(set vim.opt.sidescrolloff 8)
(vim.opt.display:append :lastline)

(vim.cmd "set number")
(vim.cmd "set colorcolumn=80,120")
(vim.cmd "set clipboard+=unnamedplus")
(vim.cmd "set laststatus=2")

(set vim.g.python3_host_prog :/Users/tamer.cuba/.pyenv/shims/python3)
(set vim.g.transparent_background false)
(set vim.opt.termguicolors true)
(set vim.opt.scrolloff 8)
(set vim.opt.signcolumn :yes)
(set vim.opt.incsearch true)
(set vim.opt.inccommand :split)

(set vim.opt.backspace [:start :eol :indent])
(set vim.opt.splitright true)
(set vim.opt.splitbelow true)

(vim.opt.isfname:append "@-@")
(set vim.opt.updatetime 80)

(vim.diagnostic.config {:virtual_text {:prefix "●" :source :always}
                        :signs true
                        :underline true
                        :update_in_insert false
                        :severity_sort true
                        :float {:source :always}})
