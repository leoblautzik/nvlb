return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
  },
  keys = {
    -- 🔍 Búsqueda general
    { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Buscar archivos' },
    { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Buscar texto' },
    { '<leader><leader>', '<cmd>Telescope buffers<CR>', desc = 'Buffers abiertos' },
    { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'Ayuda' },

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
}
