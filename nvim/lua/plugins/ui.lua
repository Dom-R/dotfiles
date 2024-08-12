return {
  -- undo tree
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle }
    }
  },

  -- indentation visualizer
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = " " },
      scope = {
        char = "▏",
        show_start = false,
        show_end = false,
      },
    }
  },

  -- preview lines before jumping with :<number>
  {
    'nacro90/numb.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('numb').setup()
    end
  },

  -- add actions animation (ex: movement, resizing, etc)
  --{
  --  'echasnovski/mini.animate',
  --  config = function()
  --    require('mini.animate').setup()
  --  end
  --},
  {
    'rrethy/vim-illuminate',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      under_cursor = false,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end
  },

  {
    'kevinhwang91/nvim-ufo',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
          -- you can add other fields for setting up lsp server in this table
        })
      end
      require('ufo').setup()

      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    dependencies = {
      'kevinhwang91/promise-async'
    }
  },

  {
    'stevearc/oil.nvim',
    cmd = "Oil",
    config = function()
      require("oil").setup()
    end
  },
}
