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
      -- require('mini.icons').setup()
      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.statusline').setup()
      --require('mini.tabline').setup()
      require('mini.notify').setup {
        lsp_progress = {
          enable = false,
        },
      }
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
