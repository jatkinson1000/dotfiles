-- SET CUSTOM KEYMAPPINGS FOR NEOVIM

-- CHEATSHEET --
-- vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
-- 
-- - **`mode`**: The mode in which the mapping applies. Common modes include:
--     - `"n"`: Normal mode
--     - `"i"`: Insert mode
--     - `"v"`: Visual mode
--     - `"t"`: Terminal mode
--     - `"x"`: Visual block mode
--     - `"o"`: Operator-pending mode
--     - `"!"`: Command-line mode
-- - **`lhs`**: The "left-hand side" of the mapping (the key combination you press).
-- - **`rhs`**: The "right-hand side" of the mapping (the command or action to execute).
-- - **`opts`**: A table of options for the mapping. Common options include:
--     - `noremap`: If `true`, prevents the mapping from being recursively expanded.
--     - `silent`: If `true`, suppresses output of the command in the command line.
--     - `expr`: If `true`, treats the `rhs` as an expression to evaluate.
--     - `nowait`: If `true`, prevents waiting for additional key sequences.

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts) -- Move to the left window
map("n", "<C-l>", "<C-w>l", opts) -- Move to the right window
map("n", "<C-j>", "<C-w>j", opts) -- Move to the window below
map("n", "<C-k>", "<C-w>k", opts) -- Move to the window above

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", opts) -- Go to the next buffer
map("n", "<leader>bp", ":bprevious<CR>", opts) -- Go to tme previous buffer
map("n", "<leader>bd", ":bdelete<CR>", opts) -- Delete the current buffer

-- Appearance
map("n", "<leader>h", ":nohlsearch<CR>", opts)  -- Clear search highlights
map("n", "<leader>sp", ":set spell!<CR>", opts) -- Toggle spellcheck

-- Plugin specific keymappings
