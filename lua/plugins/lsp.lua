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
}
