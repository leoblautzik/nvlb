-- lua/config/options.lua
local o = vim.opt
local g = vim.g

-- Leader
g.mapleader = " "

-- Indentación
o.expandtab = true
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.backspace = { "indent", "eol", "start" }

-- Interfaz
o.number = true
o.relativenumber = true
o.showmode = false
o.cursorline = true
o.termguicolors = true

-- Archivos y undo
o.swapfile = false
o.undofile = true
-- Directorio de undo específico del entorno NVIM_APPNAME
o.undodir = vim.fn.stdpath("state") .. "/undo"

--vim.cmd.colorscheme("retrobox")
