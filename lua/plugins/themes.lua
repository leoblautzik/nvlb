-- === Función de transparencia ===
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

vim.keymap.set('n', '<leader>ttr', toggle_transparency, { desc = 'Alternar transparencia' })

-- === Selector personalizado de colorschemes ===
vim.keymap.set('n', '<leader>tc', function()
  local themes = {
    -- Catppuccin
    'catppuccin-latte',
    'catppuccin-frappe',
    'catppuccin-macchiato',
    'catppuccin-mocha',

    -- TokyoNight
    'tokyonight-day',
    'tokyonight-moon',
    'tokyonight-night',
    'tokyonight-storm',

    -- Rose Pine
    'rose-pine',
    'rose-pine-main',
    'rose-pine-moon',
    'rose-pine-dawn',

    -- Kanagawa
    'kanagawa-wave',
    'kanagawa-dragon',
    'kanagawa-lotus',

    -- Nightfox family
    'nightfox',
    'dayfox',
    'dawnfox',
    'duskfox',
    'nordfox',
    'terafox',
    'carbonfox',

    -- Everforest y Nightfly
    'everforest',
    'nightfly',
  }

  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  pickers
    .new({}, {
      prompt_title = 'Seleccionar colorscheme',
      finder = finders.new_table(themes),
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, map)
        map('i', '<CR>', function(bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)
          vim.cmd('colorscheme ' .. entry.value)
        end)
        map('n', '<CR>', function(bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)
          vim.cmd('colorscheme ' .. entry.value)
        end)
        return true
      end,
    })
    :find()
end, { desc = 'Seleccionar colorscheme favorito' })

-- === Plugins de themes ===
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
