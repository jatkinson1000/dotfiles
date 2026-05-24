-- Setup for clangd LSP
-- See https://clangd.llvm.org/
-- Requires clang to be installed manually

vim.lsp.config("clangd", {
  -- on_attach = on_attach,
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    ".git",
  },
  init_options = {
    fallbackFlags = { '-std=c++17' },
  },
})

vim.lsp.enable('clangd')
