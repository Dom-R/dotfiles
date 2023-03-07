return {
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        sources = cmp.config.sources(
          {
            { name = "path" },
          },
          {
            { name = "buffer" }
          }
        ),

        formatting = {
          format = function(entry, vim_item)
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
        { { name = "path" } },
        { { name = "cmdline" } }
        ),
      })
    end,
  },
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-path',
}
