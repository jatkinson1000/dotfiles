-- Setup fr the clangd LSP
-- See https://clangd.llvm.org/
-- Requires clang to be installed manually

return function(capabilities, on_attach)
  require('lspconfig').clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
    init_options = {
      fallbackFlags = { '-std=c++17' },
    },
  })
end
