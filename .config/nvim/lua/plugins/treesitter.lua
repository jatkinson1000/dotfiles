return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup({
      fold = { enable = true }
    })

    -- If adding parsers also add to the syntax highlighting autocommand
    treesitter.install{
      "bash",
      "cmake",
      "python",
      "c",
      "cpp",
      "fortran",
      "rust",
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "html",
      "css",
      "xml",
      "json",
      "yaml",
    }

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.foldcolumn = "auto:2"
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldnestmax = 4
  end,
}
