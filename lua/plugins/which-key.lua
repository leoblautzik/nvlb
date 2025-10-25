return {
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
}
