local vim = vim

vim.g.mapleader = " "

vim.opt.compatible = false       -- disable compatibility to old-time vi

-- MOUSE --
vim.opt.mouse = 'a'              -- enable mouse click
vim.opt.clipboard = 'unnamedplus'-- using system clipboard

-- APPEARANCE --
vim.opt.cursorline = true        -- highlight current cursor line
vim.opt.number = true            -- add line numbers
vim.opt.cc = '88'                -- set a column border for good coding style
vim.opt.breakindent = true       -- Apply indent to wrapped lines
vim.opt.signcolumn = "yes"       -- Always show the sign column

-- COLORSCHEMES -- 
vim.opt.termguicolors = true         -- better colours
vim.cmd("colorscheme ron")           -- set a builtin colorscheme May be overwritten later by in plugins

-- TABS --
vim.opt.tabstop = 2              -- number of columns occupied by a tab
vim.opt.softtabstop = 2          -- see multiple spaces as tab-stops so <BS> does the right thing
vim.opt.expandtab = true         -- converts tabs to white space
vim.opt.shiftwidth = 2           -- width for auto-indents
vim.opt.autoindent = true        -- indent a new line the same amount as the line just typed
vim.opt.backspace = { 'indent', 'eol', 'start' }  -- more powerful backspacing

-- SEARCHING --
vim.opt.showmatch = true         -- show matching brackets etc.
vim.opt.ignorecase = true        -- case insensitive
vim.opt.hlsearch = true          -- highlight search
vim.opt.incsearch = true         -- incremental search

-- COMMAND MENU --
vim.opt.wildmenu = true          -- show menu of completions
vim.opt.wildmode = 'full'        -- get bash-like tab completions
vim.opt.wildoptions = 'fuzzy'    -- show menu above as fuzzy single line

-- SCROLLING --
vim.opt.scrolloff = 8            -- Keep 8 lines visible above/below the cursor
vim.opt.sidescrolloff = 8        -- Keep 8 columns visible to the left/right of the cursor

-- WINDOW MANAGEMENT --
vim.opt.splitright = true        -- Open vertical splits to the right
vim.opt.splitbelow = true        -- Open horizontal splits below

-- SYNTAX --
-- vim.opt.spell = true             -- Set spellcheck on by default
vim.opt.syntax = 'on'            -- syntax highlighting

-- OTHER --
-- set noswapfile                   -- disable creating swap file
-- set backupdir=~/.cache/vim "     -- Directory to store backup files.
