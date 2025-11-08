-- Función auxiliar para hacer transparente un grupo sin perder el color original
local function make_transparent(group)
  local hl = vim.api.nvim_get_hl(0, { name = group })
  if hl then
    vim.api.nvim_set_hl(0, group, { fg = hl.fg, bg = 'none' })
  end
end

local transparency_enabled = false
local current_colorscheme = vim.g.colors_name

local function toggle_transparency()
  if not transparency_enabled then
    current_colorscheme = vim.g.colors_name

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })

    -- Bordes de Telescope
    make_transparent 'TelescopeNormal'
    make_transparent 'TelescopeBorder'
    make_transparent 'TelescopePromptBorder'
    make_transparent 'TelescopeResultsBorder'
    make_transparent 'TelescopePreviewBorder'

    transparency_enabled = true
  else
    if current_colorscheme and current_colorscheme ~= '' then
      vim.cmd('colorscheme ' .. current_colorscheme)
    end
    transparency_enabled = false
  end
end

-- Keymap para alternar
vim.keymap.set('n', '<leader>ttr', toggle_transparency, { desc = 'Alternar transparencia' })

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false, -- cargar inmediatamente
    priority = 1000, -- para que el tema se aplique primero
    config = function()
      require('catppuccin').setup {
        integrations = {
          telescope = true,
        },
        transparent_background = false,
      }
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      -- vim.cmd [[colorscheme tokyonight-night]]
      -- toggle_transparency()
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme rose-pine]]
    end,
  },

  {
    'rebelot/kanagawa.nvim',
  },

  {
    'EdenEast/nightfox.nvim',
  },

  {
    'bluz71/vim-nightfly-colors',
    name = 'nightfly',
    lazy = false,
    priority = 1000,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
    end,
  },
}
