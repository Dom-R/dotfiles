return {
  {
    'kyazdani42/nvim-tree.lua',
    event = "VeryLazy",
    config = function()
      require'nvim-tree'.setup {
        hijack_directories  = {
          enable = true,
          auto_open = true,
        },
        hijack_cursor       = true,
        renderer = {
          icons = {
            git_placement = "signcolumn",
            show = {
              git = true,
              folder = false,
              folder_arrow = false,
              file = false,
            }
          }
        }
      }
    end,
    keys = {
      { '<leader>n', ':NvimTreeToggle<cr>', silent = true },
    }
  },

  -- undo tree
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle }
    }
  },
}
