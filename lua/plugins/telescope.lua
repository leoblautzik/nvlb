return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Buscar archivos" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar texto" },
    { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "Buffers abiertos" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Ayuda" },
  },
  config = function()
    require("telescope").setup({})
  end,
}

