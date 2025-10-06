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

-- Toggle cíclico (usa la misma lista que Telescope)
local current_index = 1
local function toggle_theme()
  local themes = vim.fn.getcompletion('', 'color')
  current_index = current_index % #themes + 1
  set_theme(themes[current_index])
end

-- Keymaps
vim.keymap.set('n', '<leader>thp', pick_theme, { desc = 'Elegir tema con Telescope' })
vim.keymap.set('n', '<leader>ttc', toggle_theme, { desc = 'Cambiar tema cíclicamente' })

-- Aplica el último tema al iniciar
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    local last = load_last_theme() or 'catppuccin'
    set_theme(last)
  end,
})
