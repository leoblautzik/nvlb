local M = {}
local map = vim.keymap.set

M.setup = function()
  map('n', '<Space>', '', {})
  vim.g.mapleader = ' ' -- Leader key

  -- map("n", "<leader>q", ":q<CR>", { silent = true })
  -- map("n", "<leader>w", ":w<CR>", { silent = true })

  -- Toggle netrw con \
  map('n', '<leader>\\', function()
    if vim.bo.filetype == 'netrw' then
      vim.cmd 'bd'
    else
      vim.cmd 'Explore'
    end
  end, { silent = true })
  -- Toggle netrw con leader n
  map('n', '<C-n>', function()
    if vim.bo.filetype == 'netrw' then
      vim.cmd 'bd'
    else
      vim.cmd 'Explore'
    end
  end, { desc = 'Toggle netrw' })

  -- Navegación insert mode
  map('i', '<C-h>', '<Left>', { noremap = true })
  map('i', '<C-l>', '<Right>', { noremap = true })
  map('i', '<C-j>', '<Down>', { noremap = true })
  map('i', '<C-k>', '<Up>', { noremap = true })

  -- Cambiar buffers
  map('n', '<Tab>', '<cmd>bn<CR>', { noremap = true })
  map('n', '<S-Tab>', '<cmd>bp<CR>', { noremap = true })

  -- Splits
  map('n', '<leader>sh', '<C-w>s', { noremap = true })
  map('n', '<leader>sv', '<C-w>v', { noremap = true })
  map('n', '<leader>se', '<C-w>=', { noremap = true })
  map('n', '<leader>sx', '<cmd>close<CR>', { noremap = true })

  -- Diagnóstico y quickfix
  map('n', '<leader>q', function()
    local winid = vim.fn.getqflist({ winid = 0 }).winid
    if winid ~= 0 then
      vim.cmd.cclose()
    else
      vim.diagnostic.setqflist()
      vim.cmd.copen()
    end
  end, { desc = 'Toggle Quickfix con diagnósticos' })
  -------------------------------------------------------------------------------
  -- Todo esto es para mostrar la ruta con <leader>p
  -- Para mostrar y copiar al portapapeles <leader>pc
  -------------------------------------------------------------------------------
  -- Función para mostrar ruta abreviada (solo para <leader>p)
  local function get_short_path()
    local path = vim.fn.expand '%:p'
    if path == '' then
      return nil
    end

    local home = vim.fn.expand '~'
    if path:sub(1, #home) == home then
      path = '~' .. path:sub(#home + 1)
    end

    local parts = vim.split(path, '/')

    if #parts > 3 then
      for i = 2, #parts - 2 do
        if #parts[i] > 3 then
          parts[i] = parts[i]:sub(1, 3)
        end
      end
    end

    return table.concat(parts, '/')
  end

  -- Función para mostrar temporalmente en la línea de comandos
  local function show_temp_message(msg, duration_ms)
    vim.api.nvim_echo({ { msg, 'Normal' } }, false, {})
    vim.defer_fn(function()
      vim.cmd 'echo ""'
    end, duration_ms or 3000) -- limpia después de 1.5s por defecto
  end

  -- <leader>p → mostrar ruta abreviada temporal
  map('n', '<leader>p', function()
    local short_path = get_short_path()
    if short_path then
      show_temp_message(short_path)
    else
      show_temp_message 'Buffer sin archivo'
    end
  end, { noremap = true, silent = true })

  -- <leader>pc → mostrar y copiar ruta completa temporal
  map('n', '<leader>pc', function()
    local full_path = vim.fn.expand '%:p'
    if full_path == '' then
      show_temp_message 'Buffer sin archivo'
    else
      vim.fn.setreg('+', full_path)
      show_temp_message('Ruta copiada: ' .. full_path)
    end
  end, { noremap = true, silent = true })
  -------------------------------------------------------------------------------
end
return M
