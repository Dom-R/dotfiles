-- install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- helpers
local g = vim.g      -- a table to access global variables
local map = vim.keymap.set

-- package manager
--- git clone https://github.com/wbthomason/packer.nvim "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/packer.nvim
return require('packer').startup(function()
  -- packer manages itself
  use {
    'wbthomason/packer.nvim',
  }
  vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
    ]])

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-Down>"] = require('telescope.actions').cycle_history_next,
              ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
              ["<C-f>"] = require('telescope.actions').to_fuzzy_refine,
            },
          },
        }
      }
    end
  }
  map('n', '<leader>f', function()
    require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--smart-case', '-g', '!.git' }})
  end)
  map('n', '<leader>g', '<cmd>Telescope live_grep<cr>')
  map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
  map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')

  -- undo tree
  use 'mbbill/undotree'
  map('n', '<leader>u', ':UndotreeToggle<cr>')

  -- git integration
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  --use 'tyrannicaltoucan/vim-quantum'

  use 'echasnovski/mini.base16'
  require('mini.base16').setup({
    palette = {
      base00 = '#212121',
      base01 = '#212121',
      base02 = '#474646',
      base03 = '#6a6c6c',
      base04 = '#b7bdc0',
      base05 = '#b7bdc0',
      base06 = '#ff00ff',
      base07 = '#6a6c6c',
      base08 = '#dd7186',
      base09 = '#d7956e',
      base0A = '#d5b875',
      base0B = '#87bb7c',
      base0C = '#6a6c6c',
      base0D = '#70ace5',
      base0E = '#a48add',
      base0F = '#7681de',
    },
    plugins = { default = true }
  })

  -- allow easy folding with tree-sitter using :AerialToggle
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup({
      manage_folds = true,
      link_folds_to_tree = true
    }) end
  }
  -- do not let aerial fold file automatically when opening it
  vim.o.foldlevelstart = 99
  vim.o.foldlevel = 99

  -- status line
  use {
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
  }

  -- indentation visualizer
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        char = "",
        context_char = "⋅",
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

  -- preview lines before jumping with :<number>
  use {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end
  }

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require'nvim-tree'.setup {
        hijack_directories  = {
          enable = true,
          auto_open = true,
        },
        hijack_cursor       = true,
        renderer = {
          icons = {
            git_placement = "signcolumn",
            show = {
              git = true,
              folder = false,
              folder_arrow = false,
              file = false,
            }
          }
        }
      }
    end
  }
  map('n', '<leader>n', ':NvimTreeToggle<cr>')

  -- tree-sitter
  -- to install languages use :TSInstall <lang>
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "vim", "lua", "bash", "regex", "markdown", "markdown_inline", "ruby" },

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
  }

  -- automatic annotations/comments with :Neogen
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  }

  use 'rrethy/nvim-treesitter-endwise'
  require('nvim-treesitter.configs').setup {
    endwise = {
      enable = true
    }
  }

  -- fancy notifications
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
      vim.notify.setup({
        background_colour = "Normal",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "",
          WARN = ""
        },
        level = "info",
        minimum_width = 50,
        render = "default",
        stages = "slide",
        timeout = 5000
      })
      require("telescope").load_extension("notify")
    end
  }

  use {
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("noice").setup({
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
          {
            view = "mini",
            filter = { event = "msg_show", find = ".*written" },
            --opts = { skip = true },
          },
        },
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
  --require("telescope").load_extension("noice")

  -- visual f,F,t,T search
  use {
    'jinh0/eyeliner.nvim',
    config = function()
      require('eyeliner').setup {
        highlight_on_key = true
      }
    end
  }

  --use {
  --    "williamboman/mason.nvim",
  --    "williamboman/mason-lspconfig.nvim",
  --    "neovim/nvim-lspconfig",
  --}
  --require("mason").setup()
  --require("mason-lspconfig").setup()
  --require("lspconfig").solargraph.setup{}

  -- linter
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.diagnostics.trail_space
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
