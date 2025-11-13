return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    },
    keys = {
      -- 🔍 Búsqueda general
      { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Buscar archivos' },
      { '<leader>fw', '<cmd>Telescope grep_string<CR>', desc = 'Buscar texto' },
      { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Buscar grep' },
      { '<leader><leader>', '<cmd>Telescope buffers<CR>', desc = 'Buffers abiertos' },
      { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'Ayuda' },
      -- { '<leader>tth', '<cmd>Telescope colorscheme<CR>', desc = 'Elegir colorscheme con Telescope' },
      { '<leader>fk', '<cmd>Telescope keymaps<CR>', desc = 'Search keymaps' },
      { '<leader>fr', '<cmd>Telescope oldfiles<CR>', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader>fd', '<cmd>Telescope diagnostic<CR>', desc = '[S]earch [D]iagnostics' },
      --
      -- 🧭 Git
      { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'Commits' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'Cambios sin commit' },
      { '<leader>gb', '<cmd>Telescope git_branches<CR>', desc = 'Ramas' },
    },
    config = function()
      local telescope = require 'telescope'

      telescope.setup {
        defaults = {
          -- initial_mode = 'normal',
          -- border = false,
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
}
