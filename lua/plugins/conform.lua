return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local conform = require 'conform'

      conform.setup {
        formatters_by_ft = {
          python = { 'ruff_format' }, -- Ruff como formatter único
          lua = { 'stylua' },
          c = { 'clang-format' },
          go = { 'gofumpt', 'goimports-reviser', 'golines' },
        },

        -- Formateo al guardar (opcional)
        format_after_save = true,
      }

      -- Keymap manual con mensaje en la línea de comandos
      vim.keymap.set('n', '<leader>cf', function()
        conform.format { async = true, lsp_fallback = true }
        print 'Buffer formateado con Conform' -- aparece en la línea de comandos
      end, { desc = 'Conform: format current buffer' })
    end,
  },
}
