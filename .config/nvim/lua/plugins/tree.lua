-- Nvim-tree file browser
-- For keymappings associated with tree see nvim/lua/core/keymaps.lua
-- https://github.com/nvim-tree/nvim-tree.lua

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()
