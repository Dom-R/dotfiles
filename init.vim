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

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" nnoremap <Leader>f :Files<CR>
" nnoremap <Leader>b :Buffers<CR>

Plug 'liuchengxu/vim-clap'
let g:clap_provider_grep_delay = 0
let g:clap_provider_grep_blink = [0, 0]
let g:clap_provider_grep_enable_icon = 0
nnoremap <Leader>f :Clap files<CR>
nnoremap <Leader>b :Clap buffers<CR>

Plug 'tpope/vim-endwise'
Plug 'ntpeters/vim-better-whitespace'
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

Plug 'janko-m/vim-test'
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>tn :TestNearest<CR>

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-solargraph', 'coc-pairs']
" future extensions: coc-yank, coc-sql, coc-terminal, coc-docker

" Add more text object to operate(|, [, {, etc)
Plug 'wellle/targets.vim'

" Undo tree visualization
Plug 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>

" Linter
Plug 'dense-analysis/ale'

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

" Run a alt command from a given path to return the test file.
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

" Set grep to use ripgrep with smart case
set grepprg=rg\ --smart-case\ --vimgrep

" Use leader as a shortcut to copy and paste from system buffer
vnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
