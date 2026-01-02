-- Set default capabilities for all lsp configs
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', { capabilities = capabilities })

-- configure and enable specific lsp clients
require("lsp.python")
require("lsp.rust")
vim.lsp.enable('lua_ls')
require("lsp.clang")


-- Set up keymaps
local keymap = require('utils').keymap
keymap('<leader>ds', vim.diagnostic.open_float)
keymap('[d',         vim.diagnostic.goto_prev)
keymap(']d',         vim.diagnostic.goto_next)
keymap('<leader>q',  vim.diagnostic.setloclist)
keymap('K',          function() vim.lsp.buf.hover { border = "rounded", max_height = 25, max_width = 120 } end, { desc = "Hover documentation" })

-- Jump to declarations. use <C-o> to return, and <C-i> to hop back.
keymap('gD', vim.lsp.buf.declaration)
keymap('gd', vim.lsp.buf.definition)

-- Diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.diagnostic.config({
  virtual_text = false,  -- show inline messages
  underline = true,     -- underline problematic text
  update_in_insert = false, -- don't update diagnostics while typing
  severity_sort = true,     -- sort diagnostics by severity
  -- signs = true,          -- show signs in the gutter
  signs = {                 -- show signs in the gutter and customise
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
})

-- Configure the appearance of floating boxes
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})
