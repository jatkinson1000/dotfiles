-- Setup for the pyright LSP
-- Requires pyright to be installed manually

-- Assumes we use ruff for linting and formatting so disable this for pyright.
-- See https://docs.astral.sh/ruff/editors/

return function(capabilities, on_attach)
  require("lspconfig").pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          typeCheckingMode = "strict", -- Options: "off", "basic", "strict"
          autoSearchPaths = true,      -- Search venv, cwd, and stdlib for hints
          useLibraryCodeForTypes = true,  -- Use imported libraries in Pyright
          diagnosticMode = "workspace",   -- Options: "workspace", "openFiles"
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
        },
      },
    },
  })
end
