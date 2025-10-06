-- themes.lua
local theme_state_file = vim.fn.stdpath 'data' .. '/last_theme.txt'

-- Guarda el tema actual en el archivo
local function save_theme(name)
  local f = io.open(theme_state_file, 'w')
  if f then
    f:write(name)
    f:close()
  end
end

-- Lee el último tema guardado
local function load_last_theme()
  local f = io.open(theme_state_file, 'r')
  if f then
    local theme = f:read '*l'
    f:close()
    return theme
  end
  return nil
end
-- Lista de temas en el orden que quieras recorrer
local themes = { 'catppuccin', 'rose-pine', 'nightfox', 'tokyonight', 'dracula', 'gruvbox', 'kanagawa' }

-- Índice actual
local current_index = 1

-- Aplica el tema y lo guarda
local function set_theme(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  local _, lualine = pcall(require, 'lualine')
  if ok then
    vim.notify('🎨 Tema aplicado: ' .. name, vim.log.levels.INFO)
    save_theme(name)
    lualine.setup { options = { theme = name } }
  else
    vim.notify('Error cargando tema: ' .. name .. '\n' .. err, vim.log.levels.ERROR)
  end
end

-- Función para toggle cíclico
local function toggle_theme()
  current_index = current_index % #themes + 1 -- Avanza al siguiente, vuelve al inicio
  set_theme(themes[current_index])
end

-- Keymap para toggle
vim.keymap.set('n', '<leader>ttc', toggle_theme, { desc = 'Toggle entre todos los temas' })

-- Config común de los keymaps
local function setup_theme_keymaps()
  vim.keymap.set('n', '<leader>thc', function()
    set_theme 'catppuccin'
  end, { desc = 'Tema Catppuccin (dark)' })

  vim.keymap.set('n', '<leader>thr', function()
    set_theme 'rose-pine'
  end, { desc = 'Tema Rose Pine (moon)' })

  vim.keymap.set('n', '<leader>tht', function()
    set_theme 'tokyonight'
  end, { desc = 'Tema Tokyo Night (night)' })
  vim.keymap.set('n', '<leader>thf', function()
    set_theme 'nightfox'
  end, { desc = 'Tema NightFox (nightfox)' })
  vim.keymap.set('n', '<leader>thd', function()
    set_theme 'dracula'
  end, { desc = 'Tema Dracula (soft)' })
  vim.keymap.set('n', '<leader>thg', function()
    vim.o.background = 'dark'
    set_theme 'gruvbox'
  end, { desc = 'Tema gruvbox' })
  vim.keymap.set('n', '<leader>thk', function()
    vim.o.background = 'dark'
    set_theme 'kanagawa'
  end, { desc = 'Tema Kanagawa' })
end
------------------------------------------------
-- Temas: Catppuccin por defecto
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

  {
    'lazy.nvim',
    init = function()
      -- Este autocmd se ejecuta una vez que todos los plugins están listos
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          setup_theme_keymaps()
          local last = load_last_theme() or 'catppuccin'
          set_theme(last)
        end,
      })
    end,
  },
}
