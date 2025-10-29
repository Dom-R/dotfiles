vim.lsp.enable({
  "ruby_lsp", "harper_ls"
})

vim.lsp.config('harper_ls', {
  settings = {
    ["harper-ls"] = {
      userDictPath = "~/harper_dict.txt",
      linters = {
        SentenceCapitalization = false,
        LongSentences = false,
        Dashes = false,
        BoringWords = true
      }
    }
  },
})

vim.diagnostic.config({
  virtual_lines = true
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
