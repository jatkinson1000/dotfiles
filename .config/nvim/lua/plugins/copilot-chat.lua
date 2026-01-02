return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",

    opts = {
      model = 'claude-sonnet-4.5', -- AI model to use, press $ in chat to see
      temperature = 0.1,           -- Lower = focused, higher = creative
      window = {
        layout = 'float',          -- 'vertical', 'horizontal', 'float'
        width = 0.5,
        border = 'rounded',        -- 'single', 'double', 'rounded', 'solid'
        title = ' Copilot Chat',
      },
      headers = {
        user = ' You',
        assistant = ' Copilot',
        tool = ' Tool',
      },
      auto_insert_mode = true,     -- Enter insert mode when opening
    },

    init = function()
      -- Disable Copilot by default and map Ctrl + a + i to toggle this
      vim.g.copilot_enabled = false
      function ToggleCopilot()
        vim.g.copilot_enabled = not vim.g.copilot_enabled
        print("Copilot " .. (vim.g.copilot_enabled and "enabled" or "disabled"))
      end
      require('utils').keymap('<C-a><C-i>', ToggleCopilot, {desc = "Toggle Copilot."})
      require('utils').keymap('cco', '<cmd>CopilotChatOpen<cr>', {desc = "Open CopilotChat."})
      require('utils').keymap('ccc', '<cmd>CopilotChatClose<cr>', {desc = "Close CopilotChat."})
    end,

  },
}
