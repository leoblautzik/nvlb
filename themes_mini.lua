-- Guarda tu esquema oscuro preferido
local dark_scheme = 'kanagawa-wave' -- cambiá esto al tuyo si querés
local light_scheme = 'catppuccin-latte'

local current_is_light = false

local function toggle_colorscheme()
  if current_is_light then
    vim.cmd.colorscheme(dark_scheme)
    current_is_light = false
  else
    vim.cmd.colorscheme(light_scheme)
    current_is_light = true
  end
end

vim.keymap.set('n', '<leader>tc', toggle_colorscheme, { desc = 'Alternar entre oscuro y latte' })

-- plugins de themes
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = { telescope = true },
        transparent_background = false,
      }
    end,
  },
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 1000 },
  { 'rebelot/kanagawa.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
    end,
  },
}
