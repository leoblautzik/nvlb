-- lua/config/autocmds/numbers.lua

-- Alternar relativenumber en insert mode
local M = {}

M.setup = function()
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
end

return M
