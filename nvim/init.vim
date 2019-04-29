" Autoinstall VimPlug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'

" Closes NERDTree when it is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files in NERDtree
let NERDTreeShowHidden=1

Plug 'srstevenson/vim-picker'
let g:picker_find_executable = 'rg'
let g:picker_find_flags = '--color never --files'
nnoremap <Leader>f :PickerEdit<CR>
nnoremap <Leader>b :PickerBuffer<CR>

Plug 'tpope/vim-endwise'
Plug 'ntpeters/vim-better-whitespace'
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

Plug 'janko-m/vim-test'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'justinmk/vim-sneak'

" Uses label mode to jump between searches
let g:sneak#label = 1

" Installing quantum colorscheme with dark mode enabled
Plug 'tyrannicaltoucan/vim-quantum'
let g:quantum_black = 1

Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'quantum'}

" Highligh yanks
Plug 'machakann/vim-highlightedyank'

" Code Completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Add more text object to operate(|, [, {, etc)
Plug 'wellle/targets.vim'

" Undo tree visualization
Plug 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>

call plug#end()

" Tab properties
set softtabstop=0 expandtab shiftwidth=2 smarttab

" Turn on line numbers
set number

" Ignore case on patterns unless specified
set ignorecase
set smartcase

" Turn on syntax
syntax on

" Turn on dark brackground and true color
set background=dark
set termguicolors

" Set up quantum as colorscheme in silent mode due to it not existing when
" freshly installed
silent! colorscheme quantum

" Enable esc to exit terminal inside terminal mode
tnoremap <Esc> <C-\><C-n>

" Enable highlighting and previewing substitutions
set inccommand=split

" Saving keystrokes when moving between splits
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Run a given vim command on the results of alt from a given path.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Find the alternate file for the current path and open it
nnoremap <Leader>. :w<CR>:call AltCommand(expand('%'), ':e')<CR>
