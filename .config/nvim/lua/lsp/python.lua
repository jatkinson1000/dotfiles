-- Set up Python lsp with ruff and pyright
-- Requires both ruff and pyright to be installed manually - can be via active venv

-- enable ruff
vim.lsp.enable('ruff')

-- enable pyright
vim.lsp.config('pyright', {
  settings = {
    ['pyright'] = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    ['python'] = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  }
})
vim.lsp.enable('pyright')
