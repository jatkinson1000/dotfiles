-- Setup for the pyright LSP
-- Requires pyright to be installed manually

-- Assumes we use ruff for linting and formatting so disable this for pyright.
-- See https://docs.astral.sh/ruff/editors/

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').pyright.setup {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
  capabilities = capabilities,
}
