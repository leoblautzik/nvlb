------------------------------------------------
-- Treesitter
------------------------------------------------
return  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "python", "go", "javascript", "json" },
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },

            -- Folding con Treesitter
            fold = {
                enable = true,
            },

            -- Módulo de contexto (muestra la función/clase actual arriba)
            context_commentstring = { enable = true, enable_autocmd = false },
            playground = { enable = true },
        })

        -- Folding automático usando Treesitter
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldlevel = 99 -- inicia con todo desplegado
    end,
}
