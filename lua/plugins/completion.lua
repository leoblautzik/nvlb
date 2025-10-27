return {
  -- Motor de snippets
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    build = (not jit.os:find 'Windows') and 'make install_jsregexp',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },

  -- Autocompletado con blink
  {
    'saghen/blink.cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'brenoprata10/nvim-highlight-colors',
    },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      signature = { enabled = true },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },

  -- Resaltado de colores en completado
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup {
        enable_named_colors = true,
        integration = { blink_cmp = true }, -- integración con blink
      }
    end,
  },
}
