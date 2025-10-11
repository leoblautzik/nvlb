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
        virtual_lines = true,
        -- virtual_text = true,
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
      vim.lsp.config('clangd', {})
      vim.lsp.config('pyright', {})
      vim.lsp.config('gopls', {})
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

  -- ✨ Firma de funciones flotante
  {
    'ray-x/lsp_signature.nvim',
    event = 'BufRead',
    config = function()
      require('lsp_signature').setup {
        bind = true,
        floating_window = true,
      }
    end,
  },
}
