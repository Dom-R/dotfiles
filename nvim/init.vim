" Autoinstall VimPlug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
" Show hidden files in NERDtree
let NERDTreeShowHidden=1
nnoremap <Leader>n :NERDTreeToggle<CR>
" Closes NERDTree when it is the only window left open
augroup CloseNERDTreeIfOnlyBuffer
  autocmd!
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
" fzf in window mode
let g:fzf_layout = { 'window': { 'width': 0.9 , 'height': 0.8 } }

" Plug 'liuchengxu/vim-clap'
" let g:clap_provider_grep_delay = 0
" let g:clap_provider_grep_blink = [0, 0]
" let g:clap_provider_grep_enable_icon = 0
" nnoremap <Leader>f :Clap files<CR>
" nnoremap <Leader>b :Clap buffers<CR>

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

" Language Server Protocol
Plug 'neovim/nvim-lsp'

" Code Completion
Plug 'nvim-lua/completion-nvim'
set completeopt=menuone,noinsert,noselect,preview
" Fix for vim-endwise
let g:completion_confirm_key = "\<C-y>"

" Add more text object to operate(|, [, {, etc)
Plug 'wellle/targets.vim'

" Undo tree visualization
Plug 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>

" Linter
Plug 'dense-analysis/ale'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" WIP Tree Sitter Integration
"Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()

lua << EOF
  local on_attach = function()
    require'completion'.on_attach()
  end
  require'lspconfig'.solargraph.setup{on_attach=on_attach}
EOF

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

" Set up quantum as colorscheme in silent mode due to fresh installs
silent colorscheme quantum

" Enable esc to normal mode inside terminal mode with the exception of fzf
augroup EscToNormalModeOnTerminalUnlessFZF
  autocmd!
  autocmd TermOpen * if !exists("b:fzf") | tnoremap <buffer> <Esc> <C-\><C-n> | endif
augroup END

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
nnoremap <silent> <Leader>. :w<CR>:call AltCommand(expand('%'), ':e')<CR>

" Set grep to use ripgrep with smart case
set grepprg=rg\ --smart-case\ --vimgrep

" Use leader as a shortcut to copy and paste from system buffer
vnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Strips any kind of carriage when copy/pasting. Ex: ^M
if !empty($WAYLAND_DISPLAY)
  let g:clipboard = {
        \   'name': 'wayland-strip-carriage',
        \   'copy': {
        \      '+': 'wl-copy --foreground --type text/plain',
        \      '*': 'wl-copy --foreground --type text/plain --primary',
        \    },
        \   'paste': {
        \      '+': {-> systemlist('wl-paste --no-newline | tr -d "\r"')},
        \      '*': {-> systemlist('wl-paste --no-newline --primary | tr -d "\r"')},
        \   },
        \   'cache_enabled': 1,
        \ }
endif
