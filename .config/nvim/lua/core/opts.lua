local options = {
  compatible = false,             -- Ensure vi compatibility off

  -- -- -- MOUSE -- -- --
  mouse = "a",                    -- Mouse click enabled

  -- -- -- APPEARANCE -- -- --
  cursorline = true,              -- Highlight current line
  colorcolumn = "88",             -- Show a line limit at 88
  number = true,                  -- Show line number in gutter
  relativenumber = true,          -- Show relative line number
  wrap = true,                    -- Wrap long lines?
  linebreak = true,               -- Don't split words when wrapping
  breakindent = false,            -- Apply indentation to wrapped lines?
  signcolumn = "yes",             -- Show sign column?
  -- -- Folding -- -- 
  foldmethod = "expr",
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  foldcolumn = "auto:2",
  foldlevel = 99,
  foldlevelstart = 99,
  foldnestmax = 4,


  -- -- -- COLOURSCHEMES -- -- --
  termguicolors = true,           -- Better 24-bit colors

  -- -- -- SCROLLING -- -- --
  scrolloff = 4,                  -- Keep lines visible top/bottom
  sidescrolloff = 8,              -- Keep cols visible left/right

  -- -- -- SYNTAX -- -- --
  syntax = ON,                    -- Allow syntax highlighting to change based on filetype
  showmatch = true,               -- show matching bracket pairs etc

  -- -- -- COPYING -- -- --
  clipboard = "unnamedplus",      -- Use the "+" clipboard register(allows access to system clipboard)

  -- -- -- TABS -- -- --
  tabstop = 2,                    -- Number of cols occupied by a tab
  softtabstop = 2,                -- Spaces inserted/removed by tab/<BS>
  expandtab = true,               -- Convert tabs to whitespace
  autoindent = true,              -- Apply autoindentation
  shiftwidth = 2,                 -- Autoindent width
  backspace = { "indent", "eol", "start"}, -- backspace over indenys, lines, insert-start

  -- -- -- COMMAND MENU -- -- --
  wildmenu = true,                -- Show menu completions
  wildmode = "full",              -- bash-like completions in menu
  wildoptions = "fuzzy",          -- Single-line fuzzy menu display

  -- -- -- SEARCHING -- -- --
  ignorecase = true,              -- Case-insensitive when searching
  hlsearch = true,                -- Highlight matches
  incsearch = true,               -- Highlight matches whilst typing

  -- -- -- WINDOWS -- -- --
  splitbelow = true,              -- Open split below
  splitright = true,              -- Open vsplit to right
}

for key, val in pairs(options) do
  vim.opt[key] = val
end

vim.cmd("colorscheme ron")        -- Set ron as base colorscheme (overwritten later by plugins)
