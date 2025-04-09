-- Setup for the ruff LSP
-- See https://docs.astral.sh/ruff/editors/
-- Requires ruff to be installed manually

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

return function(capabilities, on_attach)
  -- Register the custom server if it is not already registered
  -- Required on macOS as seems unable to pick up default config for ruff
  if not configs.ruff then
    configs.ruff = {
      default_config = {
        cmd = { "ruff", "server" }, -- Command to start the server
        filetypes = { "python" }, -- Filetypes the server should attach to
        root_dir = function(fname)
          return lspconfig.util.root_pattern('pyproject.toml', 'ruff.toml', '.ruff.toml')(fname)
            or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
        end,
        single_file_support = true,
        settings = {}, -- Additional settings for the server
      },
    }
  end

  -- Set up the server
  lspconfig.ruff.setup({
    capabilities = capabilities, -- Pass capabilities
    on_attach = on_attach,       -- Pass on_attach
    init_options = {
      settings = {
        args = {}, -- Add custom arguments for ruff if needed
      },
    },
  })
end
