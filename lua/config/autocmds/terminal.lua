-- lua/config/autocmds/terminal.lua
local M = {}

-- Quitar números en terminal
M.setup = function()
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
end

return M
