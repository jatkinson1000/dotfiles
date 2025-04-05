vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "muttrc*", "neomuttrc*", "*.mutt" },
  callback = function()
    vim.lsp.start({
      name = "mutt",
      cmd = { "mutt-language-server" }
    })
  end,
})
