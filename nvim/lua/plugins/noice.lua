return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        cmdline = {
          format = {
            cmdline = { icon = ":" },
            search_down = { icon = "/" },
            search_up = { icon = "?" },
            filter = { icon = "$" },
            lua = { icon = "" },
            help = { icon = "?" },
          },
        },
        messages = {
          view_search = "mini", -- view for search count messages. Set to `false` to disable
        },
        routes = {
          { view = "mini", filter = { event = "msg_show", find = ".*written" }, },
          --{ view = "mini", filter = { event = "msg_show", find = "Pattern not found" }, },
          { filter = { event = "msg_show", find = "search hit" }, skip = true },
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
}
