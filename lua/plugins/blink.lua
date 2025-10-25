return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = '1.*',

  opts = {
    keymap = { preset = 'enter' },
    signature = { enabled = true },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = { documentation = { auto_show = false } },
  },
  opts_extend = { 'sources.default' },
}
