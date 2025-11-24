return {
  -- automatic annotations/comments with :Neogen
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
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
    --event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- lsp configuration
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
      }
      local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
          require('lspconfig')[ls].setup({
              capabilities = capabilities
              -- you can add other fields for setting up lsp server in this table
          })
      end

      -- customize fold text to show count of lines
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰇙 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
      end

      require('ufo').setup({
        fold_virt_text_handler = handler,
        provider_selector = function(_, filetype, _)
          local lspWithOutFolding = { "ruby", "markdown", "zsh", "css", "html", "python", "json" }
          if vim.tbl_contains(lspWithOutFolding, filetype) then return { "treesitter", "indent" } end
          return { "lsp", "indent" }
        end,
      })

      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      --vim.o.foldlevelstart = 99
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
