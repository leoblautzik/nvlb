-- Estado inicial
local transparency_enabled = false
local current_colorscheme = vim.g.colors_name -- Guarda el esquema activo

-- Función para alternar transparencia
local function toggle_transparency()
  if not transparency_enabled then
    -- Guardar esquema actual antes de transparentar
    current_colorscheme = vim.g.colors_name

    -- Activar transparencia
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    --vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
    --vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })

    transparency_enabled = true
    --vim.notify('🌙 Transparencia activada', vim.log.levels.INFO)
  else
    -- Restaurar esquema original
    if current_colorscheme and current_colorscheme ~= '' then
      vim.cmd('colorscheme ' .. current_colorscheme)
      --vim.notify('☀️ Transparencia desactivada (' .. current_colorscheme .. ')', vim.log.levels.INFO)
    else
      --vim.notify('☀️ Transparencia desactivada', vim.log.levels.INFO)
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
      vim.cmd [[colorscheme catppuccin-mocha]]
    end,
  },

  {
    'folke/tokyonight.nvim',
    -- lazy = false,
    -- priority = 1000,
    -- opts = {},
    -- config = function()
    --   vim.cmd [[colorscheme tokyonight-night]]
    --   -- toggle_transparency()
    -- end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      -- vim.cmd [[colorscheme rose-pine]]
    end,
  },
}
