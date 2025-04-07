-- Setup for the ruff LSP
-- See https://docs.astral.sh/ruff/editors/
-- Requires ruff to be installed manually

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').ruff.setup({
  capabilities = capabilities,
})
