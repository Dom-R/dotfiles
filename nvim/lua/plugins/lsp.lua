return {
  {
    'neovim/nvim-lspconfig',
    priority = 800,
    config = function()
      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("lspconfig").ruby_ls.setup({
        capabilities = cmp_capabilities,
      })
      --require("lspconfig").solargraph.setup({
      --  capabilities = cmp_capabilities,
      --  settings = {
      --    solargraph = {
      --      diagnostics = true,
      --      useBundler = true,
      --    },
      --  },
      --})
    end
  },

  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = "BufEnter",
    config = function()
      require("lsp_lines").setup()

      vim.diagnostic.config({
        virtual_text = false,
      })
    end
  },

  -- linter
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.typos,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.formatting.trim_whitespace,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    -- By default, ignore any formatters provider by other LSPs
                    return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      })
    end
  },
}
