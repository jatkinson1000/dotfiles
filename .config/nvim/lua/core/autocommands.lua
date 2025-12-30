local treesitter = vim.api.nvim_create_augroup('treesitter', { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "sh",
    "cmake",
    "python",
    "cpp",
    "c",
    "fortran",
    "rust",
    "markdown",
    "lua",
    "vim",
    "html",
    "css",
    "xml",
    "json",
    "yaml",
  },
  group = treesitter,
  callback = function() vim.treesitter.start() end,
  desc = "Set syntax highlighting for any installed parsers."
})
