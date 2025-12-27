require('core.settings')     -- generic Neovim setup
require('core.keymaps')      -- set key mappings
require('core.diagnostics')  -- set diagnostics, incl. key mappings

require('plugins')        -- vim-plug config and required plugins

require('lsp')         -- Language servers

require('core.completion')   -- Customise completion. Loaded after plugins.

