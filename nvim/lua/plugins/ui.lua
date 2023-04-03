return {
  -- indentation visualizer
  {
    'lukas-reineke/indent-blankline.nvim',
    event = "BufEnter",
    config = function()
      require("indent_blankline").setup {
        use_treesitter = true,
        char = "",
        context_char = "⋅",
        show_current_context = true,
        show_current_context_start = true,
        show_trailing_blankline_indent = false,
      }
    end
  },

  -- preview lines before jumping with :<number>
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end
  },

  -- add actions animation (ex: movement, resizing, etc)
  {
    'echasnovski/mini.animate',
    config = function()
      require('mini.animate').setup()
    end
  },
}
