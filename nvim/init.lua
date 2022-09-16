-- helper functions
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local opt = vim.opt
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

require('plugins')

local indent = 2
opt.expandtab = true                           -- Use spaces instead of tabs
opt.shiftwidth = indent                        -- Size of an indent
opt.smartindent = true                         -- Insert indents automatically
opt.tabstop = indent                           -- Number of spaces tabs count for
opt.ignorecase = true                          -- Ignore case when searching
opt.smartcase = true                           -- Don't ignore case with capitals when searching
opt.inccommand = 'split'                       -- Enable highlight and preview when substituting
opt.joinspaces = false                         -- No double spaces with join after a dot
opt.scrolloff = 4                              -- Lines of context
opt.shiftround = true                          -- Round indent
opt.sidescrolloff = 8                          -- Columns of context
opt.splitbelow = true                          -- Put new windows below current
opt.splitright = true                          -- Put new windows right of current
opt.termguicolors = true                       -- True color support
opt.wildmode = 'list:longest'                  -- Command-line completion mode
opt.list = false                               -- Show some invisible characters (tabs...)
opt.number = true                              -- Line number
opt.relativenumber = true                      -- Relative line numbers
opt.wrap = false                               -- Disable line wrap
opt.showmode = false                           -- Disable showing the mode on cmd area
opt.foldexpr = 'nvim_treesitter#foldexpr()'    -- Tree-sitter based folding

-- highlight yank
autocmd("TextYankPost", {callback = function() vim.highlight.on_yank {on_visual = true} end})

-- Saving keystrokes when moving between splits
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-h>', '<C-w><C-h>')

-- Use leader as a shortcut to copy and paste from system buffer
map('v', '<Leader>y', '"+y')
map('n', '<Leader>yy', '"+yy')
map('n', '<Leader>p', '"+p')
map('v', '<Leader>p', '"+p')

-- exit terminal mode with esc
map('t', '<Esc>', '<C-\\><C-n>')
