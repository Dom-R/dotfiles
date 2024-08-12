return {
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("lspconfig").ruby_lsp.setup({
        capabilities = cmp_capabilities,
      })
    end
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }

  -- linter
  --{
  --  'jose-elias-alvarez/null-ls.nvim',
  --  dependencies = { {'nvim-lua/plenary.nvim'} },
  --  config = function()
  --    local null_ls = require("null-ls")
  --    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  --    null_ls.setup({
  --      sources = {
  --        null_ls.builtins.diagnostics.typos,
  --        null_ls.builtins.diagnostics.rubocop,
  --      },
  --      on_attach = function(client, bufnr)
  --        if client.supports_method("textDocument/formatting") then
  --          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --          vim.api.nvim_create_autocmd("BufWritePre", {
  --            group = augroup,
  --            buffer = bufnr,
  --            callback = function()
  --              vim.lsp.buf.format({
  --                filter = function(client)
  --                  -- By default, ignore any formatters provider by other LSPs
  --                  return client.name == "null-ls"
  --                end,
  --                bufnr = bufnr,
  --              })
  --            end,
  --          })
  --        end
  --      end,
  --    })
  --  end
  --},
}
