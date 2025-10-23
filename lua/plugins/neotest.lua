return {
  {
    'nvim-neotest/neotest',
    commit = 'dddbe8fe358b05b2b7e54fe4faab50563171a76d',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      -- 'antoinemadec/FixCursorHold.nvim',
      -- 'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
    },
    config = function()
      local neotest = require 'neotest'

      neotest.setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            runner = 'pytest',
          },
          require 'neotest-go' {
            experimental = { test_table = true },
            args = { '-v' },
          },
        },
      }

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map('n', '<leader>tn', function()
        neotest.run.run()
        vim.defer_fn(function()
          vim.cmd 'stopinsert'
        end, 400)
      end, opts)
      map('n', '<leader>ta', function()
        neotest.run.run(vim.fn.expand '%')
        vim.defer_fn(function()
          vim.cmd 'stopinsert'
        end, 400)
      end, opts)
      map('n', '<leader>ts', function()
        neotest.summary.toggle()
      end, opts)
      map('n', '<leader>ti', function()
        neotest.output.open { enter = true }
        vim.defer_fn(function()
          vim.cmd 'stopinsert'
        end, 400)
      end, opts)
    end,
  },
}
