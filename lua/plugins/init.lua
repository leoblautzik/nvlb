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

  -- Telescope + harpoon
  { import = 'plugins.finder' },

  -- CMP + autopairs
  -- { import = 'plugins.cmp' },

  -- blink + autopairs
  { import = 'plugins.editing' },
  { import = 'plugins.completion' },

  -- LSPs
  { import = 'plugins.lsp' },

  -- Format
  { import = 'plugins.conform' },

  -- Git signs + neotest
  { import = 'plugins.devtools' },
}
