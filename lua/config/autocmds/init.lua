-- Cargar todos los autocmds
local modules = {
	"autocmds",
	-- "python",
	-- "c",
	-- "terminal",
	-- "yank",
	-- "numbers",
	-- "cursor_restore",
}

for _, mod in ipairs(modules) do
	local ok, m = pcall(require, "config.autocmds." .. mod)
	if not ok then
		vim.notify("No se pudo cargar autocmd: " .. mod .. "\n" .. m, vim.log.levels.ERROR)
	elseif m and type(m.setup) == "function" then
		m.setup()
	end
end
