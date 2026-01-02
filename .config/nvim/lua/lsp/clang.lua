-- Setup for clangd LSP
-- See https://clangd.llvm.org/
-- Requires clang to be installed manually

vim.lsp.config("clangd", {
  -- on_attach = on_attach,
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
  init_options = {
    fallbackFlags = { '-std=c++17' },
  },
})

vim.lsp.enable('clangd')
