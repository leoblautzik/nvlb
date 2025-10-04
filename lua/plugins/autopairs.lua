return {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- se carga al entrar en modo insert
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,        -- integración con treesitter
            ts_config = {
                lua = { "string" },   -- no autopares dentro de strings si lo querés
                python = { "string" },
            },
            fast_wrap = {},         -- opcional: wrap rápido con delimitadores
            disable_filetype = { "TelescopePrompt" },
        })
    end,
}
