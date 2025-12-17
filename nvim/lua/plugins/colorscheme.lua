return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      require("tokyonight").setup({
        -- use the night style
        style = "night",
        -- transparent background
        transparent = true,
        -- disable italic at keywords
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        on_highlights = function(hl, c)
          hl.Type = {
            fg = "#c792ea"
          }
          hl["@keyword"] = {
            fg = "#89ddff"
          }
          hl.LineNr = {
            fg = "#515151"
          }
          hl.LineNrAbove = {
            fg = "#515151"
          }
          hl.LineNrBelow = {
            fg = "#515151"
          }
        end
      })

      vim.cmd[[colorscheme tokyonight]]
    end
  }
}
