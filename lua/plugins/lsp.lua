---@diagnostic disable: undefined-global
local vim = vim

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- 🔹 Teclas comunes a todos los LSPs
      local on_attach = function(_, bufnr)
        local map = function(lhs, rhs)
          vim.keymap.set('n', lhs, rhs, { buffer = bufnr, silent = true, noremap = true })
        end
        local lsp, diag = vim.lsp.buf, vim.diagnostic
        map('gd', lsp.definition)
        map('gD', lsp.declaration)
        map('gi', lsp.implementation)
        map('go', lsp.type_definition)
        map('gr', lsp.references)
        map('K', lsp.hover)
        map('<leader>rn', lsp.rename)
        map('<leader>ca', lsp.code_action)
        map('<leader>e', diag.open_float)
        map('[d', diag.goto_prev)
        map(']d', diag.goto_next)
      end

      -- ⚙️ Diagnósticos globales
      vim.diagnostic.config {
        virtual_text = { source = 'if_many', spacing = 2 },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '󰋼',
            [vim.diagnostic.severity.HINT] = '󰌵',
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }

      -- 🧩 Configuración de servidores
      local servers = {
        clangd = {
          cmd = { 'clangd', '--background-index', '--header-insertion=never' },
          init_options = { clangdFileStatus = true },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = 'basic',
                diagnosticMode = 'openFilesOnly',
                autoImportCompletions = true,
                useLibraryCodeForTypes = false,
              },
            },
          },
        },

        ruff = {
          init_options = { settings = { args = {} } },
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            on_attach(client, bufnr)
          end,
        },

        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
              completeUnimported = true,
              usePlaceholders = true,
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              diagnostics = { globals = { 'vim' } },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      }

      -- 🚀 Registro unificado
      for name, config in pairs(servers) do
        config.on_attach = config.on_attach or on_attach
        vim.lsp.config(name, config)
      end
    end,
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = true,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { 'clangd', 'pyright', 'ruff', 'gopls', 'lua_ls', 'stylua' },
        automatic_installation = true,
      }
    end,
  },
  { -- Formateo con conform
    'stevearc/conform.nvim',
    event = 'BufReadPre',
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

  -- Completion
  -- Motor de snippets
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    build = (not jit.os:find 'Windows') and 'make install_jsregexp',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
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
        preset = 'default',
        ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
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
