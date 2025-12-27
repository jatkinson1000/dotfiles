-- SET CUSTOM KEYMAPPINGS FOR NEOVIM

-- CHEATSHEET --
-- vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
--
-- - `mode`: The mode in which the mapping applies. Common modes include:
--     - `"n"`: Normal mode
--     - `"i"`: Insert mode
--     - `"v"`: Visual mode
--     - `"t"`: Terminal mode
--     - `"x"`: Visual block mode
--     - `"o"`: Operator-pending mode
--     - `"!"`: Command-line mode
-- - `lhs`: The "left-hand side" of the mapping (the key combination you press).
-- - `rhs`: The "right-hand side" of the mapping (the command or action to execute).
-- - `opts`: A table of options for the mapping. Common options include:
--     - `noremap`: If `true`, prevents the mapping from being recursively expanded.
--     - `silent`: If `true`, suppresses output of the command in the command line.
--     - `expr`: If `true`, treats the `rhs` as an expression to evaluate.
--     - `nowait`: If `true`, prevents waiting for additional key sequences.

-- Key Shorthand
-- <C-x>   : Ctrl + x
-- <CR>    : Carriage Return
-- <A>/<M> : Alt or Meta key
-- <Esc>   : Escape

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

function keymap(lhs, rhs, mode)
  local options = { noremap = true, silent = true }
  mode = mode or "n"
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Buffer navigation
keymap("<leader>bn", ":bnext<CR>")     -- Go to the next buffer
keymap("<leader>bp", ":bprevious<CR>") -- Go to the previous buffer
keymap("<leader>bd", ":bdelete<CR>")   -- Delete the current buffer

-- Appearance
keymap("<Esc>", ":nohlsearch<CR>")      -- Clear search highlights
keymap("<leader>h", ":nohlsearch<CR>")  -- Clear search highlights
keymap("<leader>sp", ":set spell!<CR>") -- Toggle spellcheck

-- Plugin specific keymappings
--
