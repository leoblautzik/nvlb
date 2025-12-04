local transparency_enabled = false
-- local transparency_file = vim.fn.stdpath 'state' .. '/transparency_enabled.txt'
local scheme_file = vim.fn.stdpath 'state' .. '/last_colorscheme.txt'

local function apply_transparency()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })

  local function make_transparent(group)
    local hl = vim.api.nvim_get_hl(0, { name = group })
    if hl then
      vim.api.nvim_set_hl(0, group, { fg = hl.fg, bg = 'none' })
    end
  end

  local telescope_groups = {
    'TelescopeNormal',
    'TelescopeBorder',
    'TelescopePromptBorder',
    'TelescopeResultsBorder',
    'TelescopePreviewBorder',
  }

  for _, g in ipairs(telescope_groups) do
    make_transparent(g)
  end
end

local function remove_transparency()
  local current = vim.g.colors_name
  if current and current ~= '' then
    pcall(function()
      vim.cmd('colorscheme ' .. current)
    end)
  end
end

local function toggle_transparency()
  if not transparency_enabled then
    apply_transparency()
    transparency_enabled = true
  else
    remove_transparency()
    transparency_enabled = false
  end
end

vim.keymap.set('n', '<leader>ttr', toggle_transparency, { desc = 'Alternar transparencia' })

local function save_colorscheme(name)
  local f = io.open(scheme_file, 'w')
  if f then
    f:write(name)
    f:close()
  end
end

local function load_last_colorscheme()
  local f = io.open(scheme_file, 'r')
  if f then
    local name = f:read '*l'
    f:close()
    local ok = pcall(function()
      vim.cmd('colorscheme ' .. name)
    end)
    if ok then
      return name
    end
  end
  --vim.cmd 'colorscheme catppuccin-mocha' -- por defecto
  return 'catppuccin-mocha'
end

-- local function load_transparency()
--   local f = io.open(transparency_file, 'r')
--   if f then
--     local v = f:read '*l'
--     f:close()
--     return v == '1'
--   end
--   return false
-- end

-- Restaurar al inicio
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    load_last_colorscheme()
    -- apply_transparency()
    -- if load_transparency() then
    --   toggle_transparency()
    -- end
  end,
})

-- Selector personalizado de colorschemes
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
      previewer = nil,
      attach_mappings = function(_, map)
        local apply_scheme = function(scheme)
          local ok = pcall(function()
            vim.cmd('colorscheme ' .. scheme)
          end)
          if ok then
            save_colorscheme(scheme)
          else
            vim.notify('No se pudo cargar el tema: ' .. scheme, vim.log.levels.WARN)
          end
        end

        map('i', '<CR>', function(bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)
          apply_scheme(entry.value)
        end)

        map('n', '<CR>', function(bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)
          apply_scheme(entry.value)
        end)

        map('i', '<C-j>', function()
          local entry = action_state.get_selected_entry()
          if entry then
            apply_scheme(entry.value)
          end
          actions.move_selection_next()
        end)

        map('i', '<C-k>', function()
          local entry = action_state.get_selected_entry()
          if entry then
            apply_scheme(entry.value)
          end
          actions.move_selection_previous()
        end)

        return true
      end,
    })
    :find()
end, { desc = 'Seleccionar colorscheme favorito' })

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
