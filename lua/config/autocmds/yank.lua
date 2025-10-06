-- lua/config/autocmds/yank.lua

-- Resaltar texto al copiar
local M = {}
M.setup = function()
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	})
end

return M
