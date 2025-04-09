-- Diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Set location list" })

vim.diagnostic.config({
  virtual_text = true,      -- Inline text
  signs = true,             -- Gutter signs
  underline = true,         -- Underline
  update_in_insert = false, -- Update whilst writing?
  severity_sort = true,     -- Sort Error-Warning-Hint-Info
})
