-- init.lua

-- Opciones
require('config.options').setup()

-- Keymaps
require('config.keymaps').setup()

-- Autocomandos
require('config.autocmds').setup()

-- Plugins (lazy.nvim + lista de plugins)
require 'plugins'

-- LSP servers
-- require('config.lsp').setup()

-- Snippets
-- require 'snippets'
