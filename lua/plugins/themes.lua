local theme_state_file = vim.fn.stdpath 'data' .. '/last_theme.txt'

-- Guarda el tema actual
local function save_theme(name)
  local f = io.open(theme_state_file, 'w')
  if f then
    f:write(name)
    f:close()
  end
end

-- Carga el último tema guardado
local function load_last_theme()
  local f = io.open(theme_state_file, 'r')
  if f then
    local theme = f:read '*l'
    f:close()
    return theme
  end
  return nil
end

-- Aplica el tema y actualiza lualine
local function set_theme(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  local _, lualine = pcall(require, 'lualine')
  if ok then
    vim.notify('🎨 Tema aplicado: ' .. name, vim.log.levels.INFO)
    save_theme(name)
    if lualine then
      lualine.setup { options = { theme = 'auto' } }
    end
  else
    vim.notify('❌ Error cargando tema: ' .. name .. '\n' .. err, vim.log.levels.ERROR)
  end
end

-- Telescope picker para elegir tema (lista generada al abrir)
local function pick_theme()
  local ok, pickers = pcall(require, 'telescope.pickers')
  if not ok then
    vim.notify('Telescope no está instalado', vim.log.levels.ERROR)
    return
  end

  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  -- Genera la lista de todos los colores disponibles AHORA
  local themes = vim.fn.getcompletion('', 'color')

  pickers
    .new({}, {
      prompt_title = 'Seleccionar tema',
      finder = finders.new_table { results = themes },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        local function select_theme()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            set_theme(selection[1])
          end
        end

        map('i', '<CR>', select_theme)
        map('n', '<CR>', select_theme)
        return true
      end,
    })
    :find()
end

-- Keymaps
vim.keymap.set('n', '<leader>tth', pick_theme, { desc = 'Elegir tema con Telescope' })

-- Aplica el último tema al iniciar
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    local last = load_last_theme() or 'catppuccin'
    set_theme(last)
  end,
})

------------------------------------------------
-- Plugins de temas
------------------------------------------------
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false, -- cargar inmediatamente
    priority = 1000, -- para que el tema se aplique primero
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = { light = 'latte', dark = 'mocha' },
        transparent_background = false,
        term_colors = true,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          loops = {},
          functions = { 'bold' },
          keywords = { 'italic' },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },

        integrations = {
          treesitter = true,
          cmp = true,
          telescope = true,
          gitsigns = true,
          which_key = true,
          indent_blankline = { enabled = true },
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
          },
        },
      }
    end,
  },

  -- Rose Pine
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
      }
    end,
  },

  -- Tokyo Night
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    config = function()
      require('tokyonight').setup {
        style = 'night', -- storm, night, moon, day
        transparent = false,
        terminal_colors = true,
      }
    end,
  },

  { 'EdenEast/nightfox.nvim' },

  { 'rebelot/kanagawa.nvim' },

  { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },

  {
    'Mofiqul/dracula.nvim',
    name = 'dracula',
    config = function()
      require('dracula').setup {
        style = 'default', -- Variante más dark del tema
        -- otras opciones...
      }
    end,
  },
}

-- return {
--   {
--     'catppuccin/nvim',
--     name = 'catppuccin',
--     priority = 1000,
--     lazy = false,
--     config = function()
--       require('catppuccin').setup {
--         flavour = 'mocha',
--         integrations = { treesitter = true, telescope = true, which_key = true },
--       }
--     end,
--   },
--   { 'rose-pine/neovim', name = 'rose-pine' },
--   { 'folke/tokyonight.nvim', name = 'tokyonight' },
--   { 'EdenEast/nightfox.nvim', name = 'nightfox' },
--   { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
--   { 'ellisonleao/gruvbox.nvim', name = 'gruvbox' },
--   { 'Mofiqul/dracula.nvim', name = 'dracula' },
-- }
