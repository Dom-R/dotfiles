return {
  {
    'kyazdani42/nvim-tree.lua',
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
      { '<leader>n', ':NvimTreeToggle<cr>' },
    }
  },

  -- undo tree
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', ':UndotreeToggle<cr>' }
    }
  },
}
