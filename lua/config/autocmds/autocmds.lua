-- =========================================================
-- NVLB Autocommands - módulo M
-- Centraliza y registra autocmds de manera limpia
-- =========================================================

local M = {}

M.setup = function()
	local group = vim.api.nvim_create_augroup("nvlb_autocmds", { clear = true })

	-- -------------------------------------------------------
	-- 🧠 Resalta texto al hacer yank (copiar)
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
		end,
	})

	-- -------------------------------------------------------
	-- 🧠 Restaurar última posición del cursor y scroll
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd("BufReadPost", {
		callback = function()
			if vim.tbl_contains({ "gitcommit", "gitrebase" }, vim.bo.filetype) then
				return
			end
			if vim.fn.line([["]]) > 0 and vim.fn.line([["]]) <= vim.fn.line("$") then
				vim.fn.setpos(".", vim.fn.getpos([["]]))
				vim.cmd("normal! zv")
			end
			local view = vim.fn.winsaveview()
			vim.schedule(function()
				vim.fn.winrestview(view)
			end)
		end,
	})

	-- -------------------------------------------------------
	-- 🧠 Formatear automáticamente antes de guardar
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd("BufWritePre", {
		desc = "Format buffer before saving",
		group = group,
		pattern = { "*.py", "*.go", "*.c", "*.h" },
		callback = function()
			local clients = vim.lsp.get_active_clients({ bufnr = 0 })
			if next(clients) ~= nil then
				vim.lsp.buf.format({ async = false })
			end
		end,
	})

	-- -------------------------------------------------------
	-- 🌈 Actualiza la lualine cuando cambia el esquema de colores
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd("ColorScheme", {
		desc = "Sync Lualine with colorscheme",
		group = group,
		callback = function()
			local ok, lualine = pcall(require, "lualine")
			if ok then
				lualine.setup({ options = { theme = "auto" } })
			end
		end,
	})

	-- -------------------------------------------------------
	-- 🔄 Ajustes visuales al entrar en buffers
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd("BufEnter", {
		desc = "Enable relative numbers and cursorline",
		group = group,
		callback = function()
			vim.opt.number = true
			vim.opt.relativenumber = true
			vim.opt.cursorline = true
		end,
	})

	vim.api.nvim_create_autocmd("TermOpen", {
		desc = "Disable relative numbers in terminal",
		group = group,
		callback = function()
			vim.opt.relativenumber = false
		end,
	})

	-- -------------------------------------------------------
	-- Alternar relativenumber en insert mode
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		pattern = "*",
		callback = function()
			vim.wo.relativenumber = false
			vim.wo.number = true
		end,
	})
	vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		pattern = "*",
		callback = function()
			vim.wo.relativenumber = true
			vim.wo.number = true
		end,
	})

	-- -------------------------------------------------------
	-- Quitar números en terminal
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd("TermOpen", {
		group = vim.api.nvim_create_augroup("custom-term-open", {
			clear = true,
		}),
		callback = function()
			vim.opt.number = false
			vim.opt.relativenumber = false
			vim.cmd.startinsert()
		end,
	})

	-- -------------------------------------------------------
	-- 🚀 Al iniciar Neovim, aplicar último tema usado
	-- -------------------------------------------------------
	-- vim.api.nvim_create_autocmd("VimEnter", {
	-- 	desc = "Apply last used theme at startup",
	-- 	group = group,
	-- 	callback = function()
	-- 		local ok, themes = pcall(require, "themes")
	-- 		if ok and themes.apply_last_theme then
	-- 			themes.apply_last_theme()
	-- 		end
	-- 	end,
	-- })

	-- -------------------------------------------------------
	-- Plantillas para archivos C
	-- -------------------------------------------------------
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = "*.c",
		callback = function()
			vim.api.nvim_buf_set_lines(0, 0, 0, false, {
				"#include <stdio.h>",
				"",
				"int main()",
				"{",
				"    return 0;",
				"}",
			})
			vim.api.nvim_win_set_cursor(0, { 4, 4 })
		end,
	})

	-- -------------------------------------------------------
	-- Plantillas para archivos Python
	-- -------------------------------------------------------
	-- Archivos normales
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = "*.py",
		callback = function()
			local filename = vim.fn.expand("%:t")
			if filename:match("^test_") or filename:match("_test%.py$") then
				return
			end

			vim.api.nvim_buf_set_lines(0, 0, 0, false, {
				"def main():",
				"    pass",
				"",
				'if __name__ == "__main__":',
				"    main()",
			})
			vim.api.nvim_win_set_cursor(0, { 2, 4 })
		end,
	})

	-- Archivos de test
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = { "test_*.py", "*_test.py" },
		callback = function()
			local filepath = vim.fn.expand("%:p")
			local relative = filepath:gsub(vim.fn.getcwd() .. "/", "")
			local parts = vim.split(relative, "/")
			local dir = parts[#parts - 1] or ""
			local file = parts[#parts] or ""
			file = file:gsub("%.py$", ""):gsub("^test_", ""):gsub("_test$", "")

			local function to_camel(s)
				local res = {}
				for word in string.gmatch(s, "[^_]+") do
					table.insert(res, word:sub(1, 1):upper() .. word:sub(2))
				end
				return table.concat(res)
			end

			local class_name = "Test" .. to_camel(dir) .. to_camel(file)

			vim.api.nvim_buf_set_lines(0, 0, 0, false, {
				"import unittest",
				"",
				"class " .. class_name .. "(unittest.TestCase):",
				"    def test_example(self):",
				"        self.assertEqual(1+1,2)",
				"",
				"if __name__ == '__main__':",
				"    unittest.main()",
			})
			vim.api.nvim_win_set_cursor(0, { 4, 8 })
		end,
	})
end

return M
