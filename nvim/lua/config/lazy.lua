local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
 { import = "plugins" },

  -- automatic annotations/comments with :Neogen
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
})
