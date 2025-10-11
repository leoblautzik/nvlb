return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme catppuccin-mocha]]
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd [[colorscheme tokyonight-night]]
    end,
  },
  {
    'sainnhe/gruvbox-material',
    name = 'gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foregraund = 'mix'
      vim.g.gruvbox_material_ui_contrast = 'high'
      -- vim.cmd [[colorscheme gruvbox_material ]]
    end,
  },
  {
    'navarasu/onedark.nvim',
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'deep',
      }
      -- Enable theme
      -- require('onedark').load()
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        variant = 'moon', -- auto, main, moon, dawn
        dark_variant = 'moon', -- main, moon, or dawn
        disable_background = false,
        styles = {
          bold = false,
          italic = false,
          transparency = false,
        },
        -- vim.cmd [[colorscheme rose-pine ]]
      }
    end,
  },
  -- { 'EdenEast/nightfox.nvim' },
  --
  -- { 'rebelot/kanagawa.nvim' },
}
