-- Without this we would need to install tree-sitter parsers manually to the machine,
--   set them up in nvim, then copy .scm query files across to an nvim reference point.
-- This plugin automates all of that installing to a location and copying.
-- It also reinstantiates the autoinstall process we well as providing TSManager gui.
--

return {
  "romus204/tree-sitter-manager.nvim",
  -- dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    require("tree-sitter-manager").setup({
      -- Default Options
      -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
      -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
      -- auto_install = false, -- if enabled, install missing parsers when editing a new file
      -- highlight = true, -- treesitter highlighting is enabled by default
      -- languages = {}, -- override or add new parser sources
      ensure_installed = {
        "bash",
        "cmake",
        "c",
        "cpp",
        "css",
        "fortran",
        "html",
        "json",
        "julia",
        "ledger",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      auto_install = true,
    })
  end
}
