---@diagnostic disable: undefined-global
local vim = vim

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- 🧭 Función on_attach: mapea teclas cuando el LSP está activo
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }

        -- Navegación LSP
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      end

      -- ⚙️ Configuración global de diagnósticos
      vim.diagnostic.config {
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local msg = diagnostic.message
            return msg
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

      -- 🔧 Configuración de servidores LSP
      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--background-index', '--header-insertion=never' },
        init_options = { clangdFileStatus = true },
        on_attach = on_attach,
      })

      vim.lsp.config('pyright', {
        on_attach = on_attach,
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
      })

      vim.lsp.config('ruff', {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          on_attach(client, bufnr)
        end,
      })

      vim.lsp.config('gopls', {
        on_attach = on_attach,
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
        on_attach = on_attach,
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
      })
    end,
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'clangd',
          'pyright',
          'ruff',
          'gopls',
          'lua_ls',
          'stylua',
        },
        automatic_installation = true,
      }
    end,
  },
}
