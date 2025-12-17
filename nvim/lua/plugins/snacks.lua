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
      picker = {
        -- your picker configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
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
    keys = {
      { "<leader>oy", function() Snacks.gitbrowse.open() end, mode = { "n", "v" }, desc = "Open git file in browser" },
      { "<leader>f", function() Snacks.picker.files() end, desc = "Smart Find Files" },
      { "<leader>g", function() Snacks.picker.grep() end, desc = "Grep" },
      { '<leader>b', function() Snacks.picker.buffers() end, desc = "Buffers" },
      { '<leader>h', function() Snacks.picker.help() end, desc = "Help Pages" },
      { '<leader>r', function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>q", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    },
  }
}
