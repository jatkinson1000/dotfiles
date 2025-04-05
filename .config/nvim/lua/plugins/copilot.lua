-- Set up copilot chat plugin options --
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}


-- Disable Copilot by default and map Ctrl + a + i to toggle this
vim.g.copilot_enabled = false
function ToggleCopilot()
  vim.g.copilot_enabled = not vim.g.copilot_enabled
  print("Copilot " .. (vim.g.copilot_enabled and "enabled" or "disabled"))
end
vim.api.nvim_set_keymap('n', '<C-a><C-i>', ':lua ToggleCopilot()<CR>', { noremap = true, silent = true })
