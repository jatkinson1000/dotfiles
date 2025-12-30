return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons"  -- Get icons in neovim.
    },
    config = function()
      require("nvim-tree").setup()

      -- Options
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Keymaps
      require('utils').keymap("<leader>t", ":NvimTreeToggle<cr>")
    end,
  },
}
