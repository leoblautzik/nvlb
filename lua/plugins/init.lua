return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        transparent_background = false,
      }
      vim.cmd [[colorscheme tokyonight-night]]
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
      --vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
    end,
  },
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   lazy = false, -- cargar inmediatamente
  --   priority = 1000, -- para que el tema se aplique primero
  --   config = function()
  --     require('catppuccin').setup {
  --       transparent_background = false,
  --     }
  --     vim.cmd [[colorscheme catppuccin-mocha]]
  --   end,
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'lua', 'python', 'go', 'javascript', 'json', 'vim', 'vimdoc', 'bash' },
        sync_install = false,
        modules = {},
        auto_install = true,
        ignore_install = { 'javascript' },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
        fold = {
          enable = true,
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        playground = { enable = true },
      }
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldlevel = 99 -- inicia con todo desplegado
    end,
  },
  -- nvim-mini
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      require('mini.starter').setup()
      require('mini.icons').setup()
      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      -- local gen_loader = require('mini.snippets').gen_loader
      -- require('mini.snippets').setup {
      --   snippets = {
      --     -- Load custom file with global snippets first (adjust for Windows)
      --     gen_loader.from_file '~/.config/nvim/snippets/global.json',
      --
      --     -- Load snippets based on current language by reading files from
      --     -- "snippets/" subdirectories from 'runtimepath' directories.
      --     gen_loader.from_lang(),
      --   },
      -- }
      -- require('mini.completion').setup()
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

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    },
    keys = {
      -- 🔍 Búsqueda general
      { '<leader>sf', '<cmd>Telescope find_files<CR>', desc = 'Buscar archivos' },
      { '<leader>sw', '<cmd>Telescope grep_string<CR>', desc = 'Buscar texto' },
      { '<leader>sg', '<cmd>Telescope live_grep<CR>', desc = 'Buscar grep' },
      { '<leader><leader>', '<cmd>Telescope buffers<CR>', desc = 'Buffers abiertos' },
      { '<leader>sh', '<cmd>Telescope help_tags<CR>', desc = 'Ayuda' },
      { '<leader>tth', '<cmd>Telescope colorscheme<CR>', desc = 'Elegir colorscheme con Telescope' },
      { '<leader>sk', '<cmd>Telescope keymaps<CR>', desc = 'Search keymaps' },
      { '<leader>s', '<cmd>Telescope oldfiles<CR>', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader>sd', '<cmd>Telescope diagnostic<CR>', desc = '[S]earch [D]iagnostics' },

      -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

      -- 🧭 Git
      { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'Commits' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'Cambios sin commit' },
      { '<leader>gb', '<cmd>Telescope git_branches<CR>', desc = 'Ramas' },
    },
    config = function()
      local telescope = require 'telescope'

      telescope.setup {
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = { prompt_position = 'bottom' },
          sorting_strategy = 'ascending',
          prompt_prefix = '   ',
          selection_caret = ' ',
          mappings = {
            i = {
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
            },
          },
        },
      }

      -- 🚀 Carga la extensión fzf si está disponible
      pcall(telescope.load_extension, 'fzf')
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<F5>', '<cmd>UndotreeToggle<CR>', { desc = 'Undo Tree' })
    end,
  },
}
