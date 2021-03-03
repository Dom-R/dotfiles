local g = vim.g      -- a table to access global variables

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

-- package manager
--- git clone https://github.com/wbthomason/packer.nvim "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/packer.nvim
return require('packer').startup(function()
  -- packer manages itself
  use {'wbthomason/packer.nvim', opt = true}

  -- nerdtree
  --use 'scrooloose/nerdtree'
  --map('n', '<leader>n', ':NERDTreeToggle<cr>')
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  map('n', '<leader>f', '<cmd>Telescope find_files<cr>')
  map('n', '<leader>g', '<cmd>Telescope live_grep<cr>')
  map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
  map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')

  -- fzf
  --use { 'junegunn/fzf', run = function() fn['fzf#install']() end }
  --use 'junegunn/fzf.vim'
  --g['fzf_layout'] = { window = { width = 0.9 , height = 0.8 } }
  --map('n', '<leader>f', ':Files<cr>')
  --map('n', '<leader>b', ':Buffers<cr>')

  -- undo tree
  use 'mbbill/undotree'
  map('n', '<leader>u', ':UndotreeToggle<cr>')

  -- git intergration
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- linter
  use 'dense-analysis/ale'

  -- status line
  use 'itchyny/lightline.vim'
  g['lightline'] = { colorscheme = 'quantum' }

  -- quantum theme
  use 'tyrannicaltoucan/vim-quantum'
  g['quantum_black'] = 1
end)
