set nocompatible

execute pathogen#infect()

set tabstop=2
set shiftwidth=2
set expandtab
set enc=utf8
set number

let mapleader = " "


syntax on
filetype plugin indent on

set t_Co=256
colorscheme mustang_vim_colorscheme_by_hcalves


" Display an incomplete command in the lower right corner of the Vim window
set showcmd

" DO NOT use arrows
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

""" NERDTree {{
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '^\.git$', '^.*\.swp$' ]

map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>
" }}


