return {
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
}
