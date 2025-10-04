local lspconfig = require("lspconfig")

-- Función genérica para on_attach
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local keymap = vim.keymap.set

	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

-- Opciones por servidor
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			},
		},
	},
	pyright = {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic",
					autoImportCompletions = true,
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
				},
			},
		},
	},

	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					autopep8 = { enabled = false },
					yapf = { enabled = false },
					black = { enabled = false },
					pylsp_black = { enabled = false },
					pylsp_isort = { enabled = false },
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					mccabe = { enabled = false },
					pylsp_mypy = { enabled = true },
					pylsp_rope = { enabled = true },
					ruff = { enabled = true, format = true },
				},
			},
		},
	},

	-- Go: gopls
	gopls = {
		settings = {
			gopls = {
				analyses = { unusedparams = true },
				staticcheck = true,
				completeUnimported = true,
				usePlaceholders = true,
			},
		},
	},

	-- C/C++: clangd
	clangd = {
		cmd = { "clangd", "--background-index" },
		init_options = { clangdFileStatus = true },
	},
}

-- Configura los servers
for server, config in pairs(servers) do
	config = vim.tbl_extend("force", { on_attach = on_attach }, config)
	lspconfig[server].setup(config)
end
