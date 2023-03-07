return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      require("lspconfig").ruby_ls.setup({})
      require("lspconfig").solargraph.setup({})
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
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.diagnostics.trail_space
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end
  },
}
