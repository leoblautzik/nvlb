-- lua/plugins/init.lua

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Tema
  { import = 'plugins.themes' },

  -- Treesitter
  { import = 'plugins.treesitter' },

  -- Lualine
  { import = 'plugins.lualine' },

  -- Telescope
  { import = 'plugins.telescope' },

  -- CMP + autopairs
  { import = 'plugins.cmp' },

  -- blink + autopairs
  -- { import = 'plugins.blink' },

  -- Tmux navigator
  { import = 'plugins.tmux-navigator' },

  -- LSPs
  { import = 'plugins.lsp' },

  -- Format
  { import = 'plugins.conform' },

  -- Git signs
  { import = 'plugins.gitsigns' },

  -- Líneas de identación
  { import = 'plugins.ibl' },

  { import = 'plugins.harpoon' },

  { import = 'plugins.which-key' },
}
