vim.opt.compatible = false       -- disable compatibility to old-time vi

-- MOUSE --
vim.opt.mouse = 'a'              -- enable mouse click
vim.opt.clipboard = 'unnamedplus'-- using system clipboard

-- APPEARANCE --
vim.opt.cursorline = true        -- highlight current cursor line
vim.opt.ttyfast = true           -- Speed up scrolling in Vim
vim.opt.number = true            -- add line numbers
vim.opt.cc = '88'                -- set a column border for good coding style
vim.opt.breakindent = true       -- Apply indent to wrapped lines

-- COLORSCHEMES -- 
vim.opt.termguicolors = true         -- better colours
-- vim.cmd("colorscheme ron")           -- set colorscheme
vim.cmd("colorscheme carbonfox")     -- set colorscheme
-- vim.cmd("colorscheme kanagawa-wave") -- set colorscheme

-- TABS --
vim.opt.tabstop = 2              -- number of columns occupied by a tab
vim.opt.softtabstop = 2          -- see multiple spaces as tab-stops so <BS> does the right thing
vim.opt.expandtab = true         -- converts tabs to white space
vim.opt.shiftwidth = 2           -- width for auto-indents
vim.opt.autoindent = true        -- indent a new line the same amount as the line just typed

-- SEARCHING --
vim.opt.showmatch = true         -- show matching brackets etc.
vim.opt.ignorecase = true        -- case insensitive
vim.opt.hlsearch = true          -- highlight search
vim.opt.incsearch = true         -- incremental search

-- MENU --
vim.opt.wildmode = 'full'        -- get bash-like tab completions
vim.opt.wildmenu = true          -- show menu of completions
vim.opt.wildoptions = 'fuzzy'    -- show menu above as fuzzy single line

-- SYNTAX --
-- vim.opt.spell = true             -- Set spellcheck on by default
vim.opt.syntax = 'on'            -- syntax highlighting

-- OTHER --
-- set noswapfile             " disable creating swap file
-- set backupdir=~/.cache/vim " Directory to store backup files.
