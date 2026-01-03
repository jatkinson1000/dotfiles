return {
  -- Core completion engine  
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',   -- LSP completion source  
      'hrsh7th/cmp-buffer',     -- Buffer completion source  
      -- 'hrsh7th/cmp-path',       -- Path completion source  
      -- 'hrsh7th/cmp-cmdline',    -- Cmdline completion source  
      'hrsh7th/vim-vsnip',      -- Snippet engine  
      'hrsh7th/cmp-vsnip',
      'neovim/nvim-lspconfig',  -- LSP configuration  
    },
    config = function()
      local cmp = require('cmp')

      -- Set up colorscheme for completion windows below
      vim.api.nvim_set_hl(0, "CmpBorder", { bg = "#2A2E2F", fg = "#6587CE" })
      vim.api.nvim_set_hl(0, "DocBorder", { bg = "#1A2C33", fg = "#00FF00" })
      vim.api.nvim_set_hl(0, "CmpBackground", { bg = "#2A2E2F" })
      vim.api.nvim_set_hl(0, "DocBackground", { bg = "#1A2C33" })

      -- Set up nvim-cmp  
      cmp.setup({
        -- specify the snippet engine  
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users  
          end,
        },

        -- Customize appearance
        window = {
          completion = {
            border = "rounded",
            winhighlight = "FloatBorder:CmpBorder,Normal:CmpBackground",
          },
          documentation = {
            border = "rounded",
            winhighlight = "FloatBorder:DocBorder,Normal:DocBackground",
          },
        },

        -- Set up keymaps in completion menu
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Complete with auto-select first item
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept item if explicitly selected
        }),

        -- Set up completion sources - see nvim-cmp wiki for more
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },  -- lsp engines
          { name = 'vsnip' },     -- vsnip users  
        }, {
          { name = 'buffer' },    -- cmp-buffer
        })
      })

      -- -- Use buffer source for `/` and `?`  
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })

      -- -- Use cmdline & path source for ':'  
      -- cmp.setup.cmdline(':', {  
      --   mapping = cmp.mapping.preset.cmdline(),  
      --   sources = cmp.config.sources({  
      --     { name = 'path' }  
      --   }, {  
      --     { name = 'cmdline' }  
      --   }),  
      --   matching = { disallow_symbol_nonprefix_matching = false }  
      -- })  

    end
  }
}
