return {
  --{
  --  'echasnovski/mini.base16',
  --  lazy = true,
  --  priority = 1000,
  --  init = function()
  --    require('mini.base16').setup({
  --      palette = {
  --        base00 = '#212121',
  --        base01 = '#212121',
  --        base02 = '#474646',
  --        base03 = '#6a6c6c',
  --        base04 = '#b7bdc0',
  --        base05 = '#b7bdc0',
  --        base06 = '#ff00ff',
  --        base07 = '#6a6c6c',
  --        base08 = '#dd7186',
  --        base09 = '#d7956e',
  --        base0A = '#d5b875',
  --        base0B = '#87bb7c',
  --        base0C = '#6a6c6c',
  --        base0D = '#70ace5',
  --        base0E = '#a48add',
  --        base0F = '#7681de',
  --      },
  --      plugins = { default = true }
  --    })
  --  end,
  --},

  {
    'marko-cerovac/material.nvim',
    priority = 1000,
    init = function ()
      require('material').setup({
        plugins = {
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        -- "gitsigns",
        -- "hop",
          "indent-blankline",
        -- "lspsaga",
          "mini",
        -- "neogit",
        -- "neorg",
           "nvim-cmp",
        -- "nvim-navic",
           "nvim-tree",
        -- "nvim-web-devicons",
        -- "sneak",
           "telescope",
        -- "trouble",
        -- "which-key",
        },

        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false, -- Disable borders between verticaly split windows
          background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false, -- Prevent the theme from setting terminal colors
          eob_lines = false -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = false -- Enable higher contrast text for darker style
        },
        lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
      })
      vim.g.material_style = "darker"
      vim.cmd 'colorscheme material'
    end
  }
}
