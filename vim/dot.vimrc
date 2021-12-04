set relativenumber

set tabstop=4
set shiftwidth=4
set expandtab
set enc=utf8
set number
set smartindent
set scrolloff=8
set incsearch
set smartcase " search will be case-sensitive if it contains an uppercase letter
"set textwidth=79
"set colorcolumn=80
set noesckeys

let mapleader = " "

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'hashivim/vim-terraform'
Plug 'godlygeek/tabular'
Plug 'preservim/nerdtree'
" Plug 'nvie/vim-flake8'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Display an incomplete command in the lower right corner of the Vim window
set showcmd

" indentation for yaml files
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

" configuration for python files
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4 textwidth=79 colorcolumn=80

" colorscheme settings

let g:gruvbox_material_background = 'medium'
set background=dark
colorscheme gruvbox-material

let g:netrw_preview = 1
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
let g:netrw_banner = 0 " Disable the banner
let g:netrw_altv = 1 " Change from the left splitting to right splitting
let g:netrw_list_hide= netrw_gitignore#Hide()

let NERDTreeShowHidden=1

let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

" Display trailing space when writing
set list listchars=tab:→\ ,trail:·

" Use ag instead of find in fzf (ignore files from .gitignore as well)
let $FZF_DEFAULT_COMMAND = 'ag -g "" --hidden --ignore .git'
let $FZF_DEFAULT_OPTS = '--reverse'

" Terminal mapping for fzf buffer - escape closes the fzf popup
" see: https://github.com/junegunn/fzf/issues/1393#issuecomment-426576577
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }


" MAPPINGS {{{
"
" ============================================================================

" DO NOT use arrows
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap <leader>ag :Ag<CR>
nnoremap <leader>f :Files<CR>

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Fugitive
nnoremap <leader>G :G<CR>
