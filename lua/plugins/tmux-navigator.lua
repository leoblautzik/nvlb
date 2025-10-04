return {
    "christoomey/vim-tmux-navigator",
    lazy = false,  -- se carga al inicio para que los keymaps funcionen
    config = function()
        -- Opcional: si querés cambiar el leader predeterminado de tmux
        vim.g.tmux_navigator_no_mappings = 1

        -- Keymaps estándar (si no los quieres, se pueden personalizar)
        vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Mover a la izquierda (tmux)" })
        vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Mover abajo (tmux)" })
        vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Mover arriba (tmux)" })
        vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Mover a la derecha (tmux)" })
        vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigateLastActive<CR>", { desc = "Último panel activo (tmux)" })
    end,
}

