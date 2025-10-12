---@diagnostic disable: undefined-global
local vim = vim

return {
  -- 🧩 LSP principal (Neovim 0.12+)
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Configuración global de diagnósticos
      vim.diagnostic.config {
        -- virtual_lines = true,
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },

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

      -- Configuración moderna (sin require("lspconfig"))
      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--background-index' },
        init_options = { clangdFileStatus = true },
      })
      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'off',
              diagnosticMode = 'openFilesOnly',
              autoImportCompletions = true,
              useLibraryCodeForTypes = false,
            },
          },
        },
      })
      vim.lsp.config('ruff', {
        init_options = {
          settings = {
            args = {}, -- Si querés --line-length=100 lo agregás acá
          },
        },
        -- ⚠️ IMPORTANTE: deshabilitamos el formateo para que lo haga Conform
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            completeUnimported = true,
            usePlaceholders = true,
          },
        },
      })
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },

  -- ⚙️ Mason (instalador de servidores LSP)
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },

  -- 🔗 Integración Mason + LSPConfig
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          -- C
          'clangd',
          -- Python
          'pyright',
          'ruff',
          -- Go
          'gopls',
          -- Lua
          'lua_ls',
          'stylua',
        },
        automatic_installation = true,
      }
    end,
  },
}
