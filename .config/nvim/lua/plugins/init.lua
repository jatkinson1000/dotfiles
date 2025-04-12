-------------
-- PLUGINS --
-------------

-- Check that plugin manager vim-plug is installed, and fetch if not --
local plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({
    'curl', '-fLo', plug_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  print("Downloaded and installed vim-plug. Restart Neovim to load plugins.")
end


-- Set a list of desired plugins --
local Plug = vim.fn['plug#']     -- Shorthand for plug command
vim.call('plug#begin', vim.fn.stdpath('data') .. '/site/plugged')

-- Colorschemes
Plug 'rebelot/kanagawa.nvim'    -- colourschemes
Plug 'EdenEast/nightfox.nvim'

-- LSP and Completion
Plug 'neovim/nvim-lspconfig'    -- Default configs for many LSP
Plug 'hrsh7th/nvim-cmp'         -- Completion engine, with below dependencies
Plug 'hrsh7th/cmp-nvim-lsp'        -- LSP completion source
Plug 'hrsh7th/cmp-buffer'          -- Buffer completion source
Plug 'hrsh7th/cmp-path'            -- Path completion source
Plug 'hrsh7th/cmp-cmdline'         -- Command-line completion source
Plug 'hrsh7th/cmp-vsnip'           -- Snippet completion source
Plug 'hrsh7th/vim-vsnip'           -- Snippet engine

Plug 'neomutt/neomutt.vim'      -- neomutt

-- Git Integration
Plug 'lewis6991/gitsigns.nvim'  -- GitSigns (Replaces vim Git-gutter from vim)
-- Dependency of heirline

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })  -- TreeSitter

Plug 'rebelot/heirline.nvim'    -- Heirline for status line

Plug 'nvim-tree/nvim-tree.lua'

Plug 'github/copilot.vim'
-- Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug('CopilotC-Nvim/CopilotChat.nvim', {['branch'] = 'main'})

Plug 'nvim-tree/nvim-web-devicons'  -- Get icons in neovim. Always load last.
-- Dependency of heirline.

vim.call('plug#end')


-- Set up autocommand to install missing plugins after loading config and entering vim
-- Checks that a directory exists for all plugins requested, and syncs if not before reloading
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  command = "if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif"
})

-- Plugin-specific configs loaded after installation --
--
-- Load plugin colorschemes
-- vim.cmd("colorscheme kanagawa-wave") -- set colorscheme
vim.cmd("colorscheme carbonfox")     -- set colorscheme
--
--Load configs
require('plugins.heirline')    -- Set up statusbar
require('plugins.gitsigns')    -- Set up git
require('plugins.treesitter')  -- Set up treesitter
require('plugins.tree')        -- Set up tree file browser
require('plugins.copilot')     -- Set up copilot
