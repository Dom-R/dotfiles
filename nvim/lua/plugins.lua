-- install packer if not installed
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- helpers
local g = vim.g      -- a table to access global variables
local map = vim.keymap.set

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

-- package manager
--- git clone https://github.com/wbthomason/packer.nvim "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/packer.nvim
return require('packer').startup(function()
  -- packer manages itself
  use {'wbthomason/packer.nvim', opt = true}

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ["<C-Down>"] = require('telescope.actions').cycle_history_next,
          ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
        },
      },
    }
  }
  --map('n', '<leader>f', '<cmd>Telescope find_files<cr>')
  map('n', '<leader>f', function()
    require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--smart-case', '-g', '!.git' }})
  end)
  map('n', '<leader>g', '<cmd>Telescope live_grep<cr>')
  map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
  map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')

  -- undo tree
  use 'mbbill/undotree'
  map('n', '<leader>u', ':UndotreeToggle<cr>')

  -- git intergration
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- catppuccino theme
  --use { 'catppuccin/nvim', as = "catppuccin" }
  --require('catppuccin').setup({ transparent_background = true, term_colors = true })
  use 'tyrannicaltoucan/vim-quantum'
  g['quantum_black'] = 1

  -- status line
  use 'nvim-lualine/lualine.nvim'
  require('lualine').setup {
    options = {
      theme = "jellybeans",
      section_separators = '',
      component_separators = '',
      icons_enabled = false
    }
  }

  -- indentation visualizer
  use 'lukas-reineke/indent-blankline.nvim'
  require("indent_blankline").setup {
    char = "",
    context_char = "⋅",
    show_current_context = true,
    show_current_context_start = true,
  }

  -- preview lines before jumping with :<number>
  use 'nacro90/numb.nvim'
  require('numb').setup()

  -- file tree
  use 'kyazdani42/nvim-tree.lua'
  require'nvim-tree'.setup {
    disable_netrw       = false,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    open_on_tab         = false,
    hijack_directories  = {
      enable = true,
      auto_open = true,
    },
    hijack_cursor       = false,
    update_cwd          = false,
    renderer = {
      icons = {
        show = {
          git = true,
          folder = false,
          file = false,
        }
      }
    }
  }
  map('n', '<leader>n', ':NvimTreeToggle<cr>')

  -- tree-sitter
  -- to install languages use :TSInstall <lang>
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    }
  }

  -- fancy notifications
  use 'rcarriga/nvim-notify'
  vim.notify = require("notify")
  vim.notify.setup({
    background_colour = "Normal",
    fps = 30,
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "",
      WARN = ""
    },
    level = "info",
    minimum_width = 50,
    render = "default",
    stages = "static",
    timeout = 5000
  })

  -- Automatically set up configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
