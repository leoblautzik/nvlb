return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    indent = {
      char = '▏', -- ultra fino
      --highlight = 'IndentLine', -- highlight definido dinámicamente abajo
      tab_char = '▏',
    },
    scope = { enabled = false },
    whitespace = { remove_blankline_trail = true },
  },
  -- config = function(_, opts)
  --   -- Definir highlight dinámico según fondo antes de cargar ibl
  --   local fg = vim.o.background == 'light' and '#d0d0d0' or '#3b3b4d'
  --   vim.api.nvim_set_hl(0, 'IndentLine', { fg = fg, nocombine = true })
  --
  --   require('ibl').setup(opts)
  -- end,
}
