return function(capabilities, on_attach)
  require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }, -- Recognize `vim` as a global variable
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
          checkThirdParty = false, -- Disable third-party library checks
        },
        telemetry = {
          enable = false, -- Disable telemetry for privacy
        },
      },
    },
  })
end
