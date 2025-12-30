local lib = {}

-- KEYMAPPINGS
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

function lib.keymap(lhs, rhs, opts)
  opts = opts or {}
  local mode = opts.mode or "n"
  local options = vim.tbl_extend("force", { noremap = true, silent = true }, opts)
  options.mode = nil
  vim.keymap.set(mode, lhs, rhs, options)
end

return lib
