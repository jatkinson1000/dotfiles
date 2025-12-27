return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,              -- Do not lazy load as main scheme
    priority = 1000,           -- Load with highest priority
    config = function()        -- load the colourscheme
      vim.cmd([[colorscheme carbonfox]])
    end,
  },
}
