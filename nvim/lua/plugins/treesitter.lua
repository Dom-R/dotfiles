return {
  -- to install languages use :TSInstall <lang>
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    priority = 900,
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "vim", "lua", "bash", "regex", "markdown", "markdown_inline", "ruby", "vimdoc", "nix" },

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
    'rrethy/nvim-treesitter-endwise',
    init = function()
      require('nvim-treesitter.configs').setup {
        endwise = {
          enable = true
        }
      }
    end,
  },
}
