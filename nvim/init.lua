-- https://github.com/neovim/neovim/pull/22668
vim.loader.enable()

-- helper functions
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local opt = vim.opt
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

require('config.lazy')
require("config.lsp")

local indent = 2
opt.expandtab = true                           -- Use spaces instead of tabs
opt.shiftwidth = indent                        -- Size of an indent
opt.smartindent = true                         -- Insert indents automatically
opt.tabstop = indent                           -- Number of spaces tabs count for
opt.ignorecase = true                          -- Ignore case when searching
opt.smartcase = true                           -- Don't ignore case with capitals when searching
opt.inccommand = 'split'                       -- Enable highlight and preview when substituting
opt.joinspaces = false                         -- No double spaces with join after a dot
opt.scrolloff = 8                              -- Lines of context
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
opt.spelloptions = 'camel,noplainbuffer'       -- Spell Checking
opt.splitkeep = 'screen'                       -- Keeps text on the same position when splitting the screen
--opt.virtualedit = 'all'                        -- allow cursor to be positioned anywhere. DISABLED due to issues when using fuzzy search on Telescope
opt.swapfile = false                           -- disable swap
opt.backup = false                             -- disable backup
opt.undodir = fn.stdpath('data') .. '/undodir' -- directory to save undo files
opt.undofile = true                            -- save file undo history
--opt.mouse = ''                                 -- disable mouse clicks DISABLED due to sometime losing focus on :Lazy or similar windows

-- Native Folding without UFO
-- TODO: Needs improvements on what to show when the fold is collapsed
-- https://www.reddit.com/r/neovim/comments/16xz3q9/treesitter_highlighted_folds_are_now_in_neovim/
-- https://www.reddit.com/r/neovim/comments/16sqyjz/finally_we_can_have_highlighted_folds/
--opt.foldmethod = "expr"
--opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--opt.foldtext = "v:lua.vim.treesitter.foldtext()"
--opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
--opt.foldlevelstart = 99
--opt.foldenable = true

-- highlight yank
-- disable when renabling virtualedit due to https://github.com/neovim/neovim/issues/21368
-- can be indefinitely enabled after https://github.com/neovim/neovim/pull/21370
autocmd("TextYankPost", {callback = function() vim.highlight.on_yank {on_visual = true} end})

-- save keystrokes when moving between splits
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-h>', '<C-w><C-h>')

-- use leader as a shortcut to copy and paste from system buffer
map('v', '<Leader>y', '"+y')
map('n', '<Leader>yy', '"+yy')
map('n', '<Leader>p', '"+p')
map('v', '<Leader>p', '"+p')

-- exit terminal mode with esc
map('t', '<Esc>', '<C-\\><C-n>')

-- keep cursor on same position when merging lines
map('n', 'J', 'mzJ`z')
map('n', 'gJ', 'mzgJ`z')

-- :DiffOrig to compare modified buffer to file
vim.api.nvim_create_user_command('DiffOrig', function()
  -- Get start buffer
  local start = vim.api.nvim_get_current_buf()

  -- `vnew` - Create empty vertical split window
  -- `set buftype=nofile` - Buffer is not related to a file, will not be written
  -- `0d_` - Remove an extra empty start row
  -- `diffthis` - Set diff mode to a new vertical split
  vim.cmd('vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis')

  -- Get scratch buffer
  local scratch = vim.api.nvim_get_current_buf()

  -- `wincmd p` - Go to the start window
  -- `diffthis` - Set diff mode to a start window
  vim.cmd('wincmd p | diffthis')

  -- Map `q` for both buffers to exit diff view and delete scratch buffer
  for _, buf in ipairs({ scratch, start }) do
    vim.keymap.set('n', 'q', function()
      vim.api.nvim_buf_delete(scratch, { force = true })
      vim.keymap.del('n', 'q', { buffer = start })
    end, { buffer = buf })
  end
end, {})

-- undo and redo on the same key
vim.keymap.set("n", "U", "<C-r>")
