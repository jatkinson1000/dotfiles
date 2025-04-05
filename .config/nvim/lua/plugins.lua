-------------
-- PLUGINS --
-------------

-- Check that plugin manager vim-plug is installed, and fetch if not --
data_dir = vim.fn.stdpath('data') .. '/site'
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) == 1 then
  os.execute('curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  print("Downloaded vim-plug")
end


-- Set a list of desired plugins --
vim.opt.filetype = 'off'
local Plug = vim.fn['plug#']     -- Shorthand for plug command
vim.call('plug#begin', data_dir .. '/plugged')

Plug 'rebelot/kanagawa.nvim'    -- colourschemes
Plug 'EdenEast/nightfox.nvim'

-- Install nvim-cmp and other required dependencies
Plug 'neovim/nvim-lspconfig'    -- default configs for many lsp plugins
Plug 'hrsh7th/cmp-nvim-lsp'     -- standardise completion from lsp plugins
Plug 'hrsh7th/cmp-buffer'       --
Plug 'hrsh7th/cmp-path'         --
Plug 'hrsh7th/cmp-cmdline'      --
Plug 'hrsh7th/nvim-cmp'    -- The main package for which the rest are dependencies
Plug 'hrsh7th/cmp-vsnip'        --
Plug 'hrsh7th/vim-vsnip'        --

Plug('neomutt/neomutt.vim')     -- neomutt

Plug('lewis6991/gitsigns.nvim')  -- GitSigns (Replaces vim Git-gutter)

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})  -- TreeSitter

Plug 'rebelot/heirline.nvim'    -- Heirline for status line

Plug 'github/copilot.vim'
-- Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug('CopilotC-Nvim/CopilotChat.nvim', {['branch'] = 'main'})

Plug 'nvim-tree/nvim-web-devicons'  -- Get icons in neovim. Always load last
-- Plug 'ryanoasis/vim-devicons'  -- Get icons in vim. Always load last

vim.call('plug#end')
vim.opt.filetype = 'on'


-- Set up autocommand to install missing plugins after loading config and entering vim--
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  command = "if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC"
})


-- Auto-update vim plug and plugins. Prefer to execute these manually for now.
-- Check for and apply any updates to vim-plug (NB slows startup.) --
-- vim.api.nvim_command('PlugUpgrade')

-- Auto-update plugins (NB slows startup and opens report.) --
-- vim.api.nvim_command('PlugUpdate')
