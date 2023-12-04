return {
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
          background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false, -- Prevent the theme from setting terminal colors
          eob_lines = false -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = true -- Enable higher contrast text for darker style
        },
        lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
      })
      vim.g.material_style = "darker"
      vim.cmd 'colorscheme material'
    end
  }
}
