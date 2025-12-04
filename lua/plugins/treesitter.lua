------------------------------------------------
-- Treesitter
------------------------------------------------
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'lua', 'python', 'go', 'javascript', 'json', 'vim', 'vimdoc', 'bash' },
      sync_install = false,
      modules = {},
      auto_install = true,
      ignore_install = { 'javascript' },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      fold = {
        enable = true,
      },
      context_commentstring = { enable = true, enable_autocmd = false },
      playground = { enable = true },
    }
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldlevel = 99 -- inicia con todo desplegado
  end,
}
