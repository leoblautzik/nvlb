-- init.lua
-- Opciones
require('config.options').setup()

-- Keymaps
require('config.keymaps').setup()

-- Autocomandos
require('config.autocmds').setup()

-- Lazy plugins manager
require 'config.lazy'

-- Plugins (lazy.nvim + lista de plugins)
-- require 'plugins'
