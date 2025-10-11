-- Configuración LSP nativa para Neovim 0.12+
local M = {}

function M.setup()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Función genérica para asignar keymaps cuando se adjunta el LSP
  local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local keymap = vim.keymap.set

    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    keymap('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end

  --------------------------------------------------------------------------
  -- Servidores LSP
  --------------------------------------------------------------------------
  local servers = {
    lua_ls = {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.luarc.json', '.luacheckrc' }, { upward = true })[1]),
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        },
      },
    },

    pyright = {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'pyproject.toml', 'setup.py' }, { upward = true })[1]),
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'basic',
            autoImportCompletions = true,
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          },
        },
      },
    },

    pylsp = {
      cmd = { 'pylsp' },
      filetypes = { 'python' },
      root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'pyproject.toml' }, { upward = true })[1]),
      settings = {
        pylsp = {
          plugins = {
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            black = { enabled = false },
            pylsp_black = { enabled = false },
            pylsp_isort = { enabled = false },
            pycodestyle = { enabled = false },
            pyflakes = { enabled = false },
            mccabe = { enabled = false },
            pylsp_mypy = { enabled = true },
            pylsp_rope = { enabled = true },
            ruff = { enabled = true, format = true },
          },
        },
      },
    },

    gopls = {
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod' },
      root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'go.mod' }, { upward = true })[1]),
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
          completeUnimported = true,
          usePlaceholders = true,
        },
      },
    },

    clangd = {
      cmd = { 'clangd', '--background-index' },
      filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
      root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'compile_commands.json' }, { upward = true })[1]),
      init_options = { clangdFileStatus = true },
    },
  }

  --------------------------------------------------------------------------
  -- Inicializa cada servidor
  --------------------------------------------------------------------------
  for _, config in pairs(servers) do
    config.capabilities = capabilities
    config.on_attach = on_attach

    vim.lsp.start(config)
  end
end

return M
