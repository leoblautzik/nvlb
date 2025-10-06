return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- opcional pero recomendado
	config = function()
		require("lualine").setup({
			options = {
				--theme = "catppuccin", -- usa el tema automáticamente
				globalstatus = false, -- single bar para todo el layout
				section_separators = { right = "", left = "" },
				component_separators = "", -- { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 1 } },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 1 } },
			},
		})
	end,
}
