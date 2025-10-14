---@diagnostic disable: undefined-global
local vim = vim

return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'windwp/nvim-autopairs',
    },
    build = 'cargo build --release', -- opcional, solo si usás Rust local
    config = function()
      local blink = require 'blink.cmp'
      local luasnip = require 'luasnip'

      require('luasnip.loaders.from_vscode').lazy_load()

      -- 🔹 Detectar fondo actual (dark/light)
      local bg = vim.opt.background:get()
      local color_fg = bg == 'dark' and '#89b4fa' or '#1e66f5'

      -- 🔹 Íconos por tipo
      local kind_icons = {
        Text = '',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰇽',
        Variable = '󰂡',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '󰙅',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '',
      }

      -- 🔹 Configuración principal
      blink.setup {
        keymap = {
          preset = 'default',
          ['<C-n>'] = { 'select_next' },
          ['<C-p>'] = { 'select_prev' },
          ['<CR>'] = { 'accept', 'fallback' },
          ['<C-d>'] = { 'scroll_docs_up' },
          ['<C-f>'] = { 'scroll_docs_down' },
          ['<C-Space>'] = { 'show' },
          ['<Esc>'] = { 'cancel' },
          ['<Tab>'] = {
            function(fallback)
              if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
          },
          ['<S-Tab>'] = {
            function(fallback)
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
          },
        },

        completion = {
          documentation = { auto_show = true },
          border = 'rounded',
          menu = {
            winblend = 10,
            border = 'rounded',
          },
        },

        sources = {
          default = {
            'lsp',
            'luasnip',
            'path',
            'buffer',
          },
        },

        -- 🔹 Formato visual
        appearance = {
          use_nvim_cmp_as_default = true,
          kind_icons = kind_icons,
          format_item = function(item)
            local menu = ({
              lsp = '[LSP]',
              luasnip = '[Snip]',
              buffer = '[Buf]',
              path = '[Path]',
            })[item.source_name] or ''
            item.menu = menu
            return item
          end,
        },
      }

      -- 🔹 Colores dinámicos según fondo
      local kinds = {
        'Function',
        'Method',
        'Variable',
        'Class',
        'Interface',
        'Module',
        'Keyword',
        'Property',
        'Constant',
        'Field',
      }
      for _, kind in ipairs(kinds) do
        vim.api.nvim_set_hl(0, 'BlinkCmpKind' .. kind, { fg = color_fg })
      end

      -- 🔹 Autopairs integración
      local npairs = require 'nvim-autopairs'
      npairs.setup { check_ts = true }
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      blink.on_confirm_done(cmp_autopairs.on_confirm_done())

      luasnip.config.set_config {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
      }
    end,
  },
}
