return {
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					python = { "ruff_format" },
					lua = { "stylua" },
					c = { "clang-format" },
					go = {
						"gofmt",
						"goimports-reviser",
						"gofumpt",
						"golines",
					},
				},
				linter_by_ft = {
					python = { "ruff" },
					lua = { "luacheck" },
					c = { "clang-tidy" },
					go = { "golangci-lint" },
				},
				format_on_save = true,
				async = true,
			})

			-- Keymap opcional para formatear manual
			vim.keymap.set("n", "<leader>cf", function()
				conform.format({ async = true })
			end, { desc = "Conform: format current buffer" })
		end,
	},
}
