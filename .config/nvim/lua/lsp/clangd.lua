-- Setup fr the clangd LSP
-- See https://clangd.llvm.org/
-- Requires clang to be installed manually

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').clangd.setup({
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
  init_options = {
    fallbackFlags = { '-std=c++17' },
  },
  capabilities = capabilities,
})
