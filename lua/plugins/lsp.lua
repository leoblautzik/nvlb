return {
	-- LSP principal
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Configuración global de diagnósticos
			vim.diagnostic.config({
				virtual_text = true, -- Mostrar texto junto a la línea del error
				signs = true, -- Mostrar iconos en el gutter
				underline = true, -- Subrayar el error
				update_in_insert = false, -- No mostrar mientras escribís
				severity_sort = true, -- Ordenar por severidad
			})

			vim.lsp.config("clangd", {})
			vim.lsp.config("pyright", {})
			vim.lsp.config("gopls", {})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- evita warnings por 'vim'
						},
					},
				},
			})
		end,
	},

	-- Mason (instalador de servidores LSP)
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason + LSPConfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd", -- C
					"pyright", -- Python
					"gopls", -- Go
					"lua_ls", -- Lua
				},
				automatic_installation = true,
			})
		end,
	},

	-- Firma de funciones flotante (opcional)
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				floating_window = true,
			})
		end,
	},
}
