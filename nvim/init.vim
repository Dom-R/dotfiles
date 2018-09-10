if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'

" Open NERDTree when opening nvim
autocmd VimEnter * NERDTree

" Focus on NERDTree if a folder was opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | wincmd p | endif

" Focus on file if a file was opened
autocmd VimEnter * if argc() == 1 && !isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | endif

" Closes NERDTree when it is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files in NERDtree
let NERDTreeShowHidden=1

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
nnoremap <Leader>p :Files<CR>

Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'molokai'}

Plug 'tpope/vim-endwise'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ntpeters/vim-better-whitespace'
let g:strip_whitespace_on_save=1

Plug 'janko-m/vim-test'

Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'justinmk/vim-sneak'

" Uses label mode to jump between searches
let g:sneak#label = 1

call plug#end()

set softtabstop=0 expandtab shiftwidth=2 smarttab
set number
set ignorecase
set smartcase

syntax on
silent! colorscheme dracula

" Enable esc to exit terminal inside terminal mode
tnoremap <Esc> <C-\><C-n>
