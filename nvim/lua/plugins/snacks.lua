return {
  {
    "folke/snacks.nvim",
    opts = {
      gitbrowse = {
        -- your gitbrowse configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      scroll = {
        -- your scroll configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      --indent = {
      --  enabled = true,
      --  char = "a",
      --  only_scope = true,
      --  only_current = false
      --  -- your indent configuration comes here
      --  -- or leave it empty to use the default settings
      --  -- refer to the configuration section below
      --}
    },
    custom_keys = {
      {
        "<leader>oy",
        function()
          Snacks.gitbrowse.open()
        end,
        mode = { "n", "v" },
        desc = "Open git file in browser"
      },
    },
  }
}
