local M = {}

local runner = require 'config.runner'
local terminal = require 'config.terminal'
local map = vim.keymap.set

M.setup = function()
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

  -------------------------------------------------------------------------------
  -- Lanzar Terminal flotante y small proporcional
  -------------------------------------------------------------------------------
  map('n', '<space>ft', terminal.open_floating, { desc = 'Open floating terminal' })
  map('n', '<space>st', terminal.open_small, { desc = 'Open small terminal (30%)' })

  -------------------------------------------------------------------------------
  -- Ejecutar archivo actual (C, Python, Go, Lua)
  -------------------------------------------------------------------------------
  map('n', '<leader>ex', runner.run_file, { desc = 'Ejecutar archivo actual' })

  -- Go Test
  map('n', '<leader>gn', runner.run_test_under_cursor, { desc = 'Go: test bajo cursor' })
  map('n', '<leader>ga', runner.run_tests_in_file, { desc = 'Go: todos los tests del archivo' })
  map('n', '<leader>gA', function()
    runner.run_tests_in_file(true)
  end, { desc = 'Go: tests archivo (verbose)' })

  -- Python Test
  -- map("n", "<leader>pt", runner.run_pytest_under_cursor, { desc = "Py: test bajo cursor" })
  map('n', '<leader>pa', runner.run_pytests_in_file, { desc = 'Py: todos los tests del archivo' })

  -- Cerrar panel de ejecución
  map('n', '<leader>ec', function()
    if vim.g.runner_win and vim.api.nvim_win_is_valid(vim.g.runner_win) then
      vim.api.nvim_win_close(vim.g.runner_win, true)
      vim.g.runner_win = nil
    else
      print 'No hay panel de ejecución activo'
    end
  end, { desc = 'Cerrar panel runner' })
  --------------------------------------------------------------------------------
end
return M
