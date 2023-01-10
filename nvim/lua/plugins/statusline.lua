return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local breadcrump_sep = " ⟩ "
      require('lualine').setup {
        options = {
          section_separators = '',
          component_separators = '',
          icons_enabled = false
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {
            {
              "filename",
              path = 1,
              separator = vim.trim(breadcrump_sep),
              fmt = function(str)
                local path_separator = package.config:sub(1, 1)
                return str:gsub(path_separator, breadcrump_sep)
              end
            },
            { "aerial", sep = breadcrump_sep },
          },
          lualine_c = {},
          lualine_x = {"lsp_progress"},
          lualine_y = {
            "diagnostics",
            {
              "encoding",
              cond = function()
                -- UTF-8 is the de-facto standard encoding and is what
                -- most users expect by default. There's no need to
                -- show encoding unless it's something else.
                local fenc = vim.opt.fenc:get()
                return string.len(fenc) > 0 and string.lower(fenc) ~= "utf-8"
              end,
            },
            "filetype",
            "fileformat",
            "progress",
          },
          lualine_z = {"location"},
        }
      }
    end
  },

}
