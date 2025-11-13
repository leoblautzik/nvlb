return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<F5>', '<cmd>UndotreeToggle<CR>', { desc = 'Undo Tree' })
    end,
  },

  -- nvim-autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },

  -- indent-blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      indent = {
        char = '▏', -- ultra fino
        tab_char = '▏',
      },
      scope = { enabled = false },
      whitespace = { remove_blankline_trail = true },
    },
  },

  { 'nvim-tree/nvim-web-devicons' },

  -- nvim-mini
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      local statusline = require 'mini.statusline'
      local lsp = vim.lsp

      -- Definir colores personalizados
      vim.api.nvim_set_hl(0, 'MiniStatuslineLSPActive', { fg = '#a6e3a1', bg = '#1e1e2e', bold = true })
      vim.api.nvim_set_hl(0, 'MiniStatuslineLSPInactive', { fg = '#6c7086', bg = '#1e1e2e', italic = true })

      local function lsp_name()
        local clients = lsp.get_clients { bufnr = 0 }
        if #clients == 0 then
          return '', 'MiniStatuslineLSPInactive'
        end
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return ' ' .. table.concat(names, ', '), 'MiniStatuslineLSPActive'
      end

      statusline.setup {
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
            local git = statusline.section_git { trunc_width = 75 }
            local diff = statusline.section_diff { trunc_width = 75 }
            local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
            local filename = statusline.section_filename { trunc_width = 140 }
            local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
            local location = statusline.section_location { trunc_width = 75 }

            local lsp_str, lsp_hl = lsp_name()

            return statusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=',
              { hl = lsp_hl, strings = { lsp_str } },
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { location } },
            }
          end,
        },
      }

      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.notify').setup { lsp_progress = { enable = false } }
    end,
  },

  -- vim-tmux-navigator
  {
    'christoomey/vim-tmux-navigator',
    lazy = false, -- se carga al inicio para que los keymaps funcionen
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      local map = vim.keymap.set
      map('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Mover a la izquierda (tmux)' })
      map('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Mover abajo (tmux)' })
      map('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Mover arriba (tmux)' })
      map('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Mover a la derecha (tmux)' })
      map('n', '<C-\\>', '<cmd>TmuxNavigateLastActive<CR>', { desc = 'Último panel activo (tmux)' })
    end,
  },

  -- which-key
  {
    'folke/which-key.nvim',
    dependencies = { 'nvim-mini/mini.icons', version = false },
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
}
