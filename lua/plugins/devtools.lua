return {
  -- neotest
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
        end, 500)
      end, opts)
      map('n', '<leader>ta', function()
        neotest.run.run(vim.fn.expand '%')
        vim.defer_fn(function()
          vim.cmd 'stopinsert'
        end, 500)
      end, opts)
      map('n', '<leader>ts', function()
        neotest.summary.toggle()
      end, opts)
      map('n', '<leader>ti', function()
        neotest.output.open { enter = true }
        vim.defer_fn(function()
          vim.cmd 'stopinsert'
        end, 500)
      end, opts)
    end,
  },
  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local gitsigns = require 'gitsigns'

      gitsigns.setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        signcolumn = true,
        numhl = false,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 500,
          ignore_whitespace = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Navegación entre cambios
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, 'Siguiente cambio')

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, 'Cambio anterior')

          -- Acciones
          map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
          map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
          map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
          map('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end, 'Blame línea')
          map('n', '<leader>hd', gs.diffthis, 'Diff actual')
        end,
      }
    end,
  },
}
