--
-- keymaps.lua
--
local map = vim.keymap.set

map('n', '<Space>', '', {})
vim.g.mapleader = ' ' -- Leader key

-- map("n", "<leader>q", ":q<CR>", { silent = true })
-- map("n", "<leader>w", ":w<CR>", { silent = true })

-------------------------------------------------------------------------------
-- Deshabilitar PgUp y PgDn en todos los modos
-------------------------------------------------------------------------------
map('', '<PageUp>', '<Nop>', { noremap = true, silent = true })
map('', '<PageDown>', '<Nop>', { noremap = true, silent = true })

-------------------------------------------------------------------------------
-- Deshabilitar flechas en modo normal
-------------------------------------------------------------------------------
map('n', '<Up>', '<Nop>', { noremap = true, silent = true })
map('n', '<Down>', '<Nop>', { noremap = true, silent = true })
map('n', '<Left>', '<Nop>', { noremap = true, silent = true })
map('n', '<Right>', '<Nop>', { noremap = true, silent = true })

-------------------------------------------------------------------------------
-- Copiar selección visual al portapapeles con Ctrl-C
-------------------------------------------------------------------------------
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true })

-------------------------------------------------------------------------------
-- Navegación con netrw
-------------------------------------------------------------------------------
-- Toggle netrw con \
map('n', '<leader>\\', function()
  if vim.bo.filetype == 'netrw' then
    vim.cmd 'bd'
  else
    vim.cmd 'Explore'
  end
end, { desc = 'Toggle netrw' })

-- Toggle netrw con leader n
map('n', '<C-n>', function()
  if vim.bo.filetype == 'netrw' then
    vim.cmd 'bd'
  else
    vim.cmd 'Explore'
  end
end, { desc = 'Toggle netrw' })
-------------------------------------------------------------------------------

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

map('n', '<leader>c', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Yank to EOL
map('n', 'Y', 'y$', { desc = 'Yank to end of line' })

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
-- Copy Full File-Path
-------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>pp', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('file:', path)
end, { desc = 'Toggle Quickfix con diagnósticos' })

-- compilar y ejecutar
vim.keymap.set('n', '<leader>ex', function()
  local file_name = vim.api.nvim_buf_get_name(0)
  local file_type = vim.bo.filetype

  if file_type == 'lua' then
    vim.cmd(':terminal lua ' .. file_name)
  elseif file_type == 'c' then
    vim.cmd(':terminal gcc ' .. file_name .. '; ./a.out')
  elseif file_type == 'python' then
    vim.cmd(':terminal python3 ' .. file_name)
  end
end)
------------------------------------------------------------------
