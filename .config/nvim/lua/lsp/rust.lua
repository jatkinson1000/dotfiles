-- Setup for rust-analyzer LSP
-- Requires rust-analyzer to be installed manually

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
      diagnostics = { enable = true },
    }
  }
})

vim.lsp.enable('rust_analyzer')
