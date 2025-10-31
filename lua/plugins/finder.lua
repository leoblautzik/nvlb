return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    },
    keys = {
      { '<leader>sf', '<cmd>Telescope find_files<CR>', desc = 'Buscar archivos' },
      { '<leader>sw', '<cmd>Telescope grep_string<CR>', desc = 'Buscar texto' },
      { '<leader>sg', '<cmd>Telescope live_grep<CR>', desc = 'Buscar grep' },
      { '<leader><leader>', '<cmd>Telescope buffers<CR>', desc = 'Buffers abiertos' },
      { '<leader>sh', '<cmd>Telescope help_tags<CR>', desc = 'Ayuda' },
      { '<leader>tth', '<cmd>Telescope colorscheme<CR>', desc = 'Elegir colorscheme con Telescope' },
      { '<leader>sk', '<cmd>Telescope keymaps<CR>', desc = 'Search keymaps' },
      { '<leader>s', '<cmd>Telescope oldfiles<CR>', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader>sd', '<cmd>Telescope diagnostic<CR>', desc = '[S]earch [D]iagnostics' },

      -- 🔍 Búsqueda general
      -- { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Buscar archivos' },
      -- { '<leader>fw', '<cmd>Telescope live_grep<CR>', desc = 'Buscar texto' },
      -- { '<leader><leader>', '<cmd>Telescope buffers<CR>', desc = 'Buffers abiertos' },
      -- { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'Ayuda' },
      -- { '<leader>km', '<cmd>Telescope keymaps<CR>', desc = 'Keymaps' },
      -- { '<leader>tth', '<cmd>Telescope colorscheme<CR>', desc = 'Elegir colorscheme con Telescope' },

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
    'ThePrimeagen/harpoon',
    config = function()
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      -- Keymaps de ejemplo
      vim.keymap.set('n', '<leader>a', mark.add_file)
      vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
      vim.keymap.set('n', '<leader>1', function()
        ui.nav_file(1)
      end)
      vim.keymap.set('n', '<leader>2', function()
        ui.nav_file(2)
      end)
      vim.keymap.set('n', '<leader>3', function()
        ui.nav_file(3)
      end)
    end,
  },
}
