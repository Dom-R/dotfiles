return {
  -- to install languages use :TSInstall <lang>
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "vim", "lua", "bash", "regex", "markdown", "markdown_inline", "ruby", "vimdoc", "nix", "comment" },

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        }
      }
    end
  },

  {
    "altermo/ultimate-autopair.nvim",
    event= { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },

  {
    'rrethy/nvim-treesitter-endwise',
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      require('nvim-treesitter.configs').setup {
        endwise = {
          enable = true
        }
      }
    end,
  },
}
