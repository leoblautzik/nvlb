-- lua/config/keymaps/runner.lua

local M = {}
local runner = require ("config.runner")
local map = vim.keymap.set

M.setup = function()
  -- Ejecutar archivo actual (C, Python, Go, Lua)
  map("n", "<leader>ex", runner.run_file, { desc = "Ejecutar archivo actual" })

  -- Go
  map("n", "<leader>gn", runner.run_test_under_cursor, { desc = "Go: test bajo cursor" })
  map("n", "<leader>ga", runner.run_tests_in_file, { desc = "Go: todos los tests del archivo" })
  map("n", "<leader>gA", function() runner.run_tests_in_file(true) end, { desc = "Go: tests archivo (verbose)" })

  -- Python
  -- map("n", "<leader>pt", runner.run_pytest_under_cursor, { desc = "Py: test bajo cursor" })
  map("n", "<leader>pa", runner.run_pytests_in_file, { desc = "Py: todos los tests del archivo" })

  -- Cerrar panel de ejecución
  map("n", "<leader>ec", function()
    if vim.g.runner_win and vim.api.nvim_win_is_valid(vim.g.runner_win) then
      vim.api.nvim_win_close(vim.g.runner_win, true)
      vim.g.runner_win = nil
    else
      print "No hay panel de ejecución activo"
    end
  end, { desc = "Cerrar panel runner" })
end

return M
