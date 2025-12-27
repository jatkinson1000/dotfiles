return function(capabilities, on_attach)
  require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
      },
    },
  })
end
