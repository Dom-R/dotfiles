return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = {
            horizontal = { width = 0.9 }
          },
          mappings = {
            i = {
              ["<C-Down>"] = require('telescope.actions').cycle_history_next,
              ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
              ["<C-f>"] = require('telescope.actions').to_fuzzy_refine,
            },
          },
        }
      }
      require("telescope").load_extension("noice")
    end,
    keys = {
      {
        "<leader>f",
        function()
          require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--smart-case', '-g', '!.git' }})
        end,
      },
      { "<leader>g", '<cmd>Telescope live_grep<cr>' },
      { '<leader>b', '<cmd>Telescope buffers<cr>' },
      { '<leader>h', '<cmd>Telescope help_tags<cr>' },
      { '<leader>r', '<cmd>Telescope resume<cr>' },
    },

  },
}
