keymap = require('utils').keymap

-- Buffer navigation
keymap("<leader>bn", ":bnext<CR>")     -- Go to the next buffer
keymap("<leader>bp", ":bprevious<CR>") -- Go to the previous buffer
keymap("<leader>bd", ":bdelete<CR>")   -- Delete the current buffer

-- Appearance
keymap("<Esc>", ":nohlsearch<CR>")      -- Clear search highlights
keymap("<leader>h", ":nohlsearch<CR>")  -- Clear search highlights
keymap("<leader>sp", ":set spell!<CR>") -- Toggle spellcheck
