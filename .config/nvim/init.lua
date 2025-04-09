require('core.settings')  -- generic Neovim setup
require('core.keymaps')   -- set key mappings

require('plugins')     -- vim-plug config and required plugins

require('lsp')         -- Language servers

require('completion')  -- Set up tab completion
-- Plugins --
require('plugins.heirline')    -- Set up statusbar
require('plugins.gitsigns')    -- Set up git
require('plugins.treesitter')  -- Set up treesitter
require('plugins.copilot')     -- Set up copilot
