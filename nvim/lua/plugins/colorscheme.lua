return {
  --use 'tyrannicaltoucan/vim-quantum'

  {
    'echasnovski/mini.base16',
    lazy = true,
    priority=1000,
    init = function()
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
    end,
  },
}
