-- lua/config/keymaps/terminal.lua
local M = {}
local map = vim.keymap.set
local terminal = require("config.terminal")

M.setup = function()
  map("n", "<space>ft", terminal.open_floating, { desc = "Open floating terminal" })
  map("n", "<space>st", terminal.open_small, { desc = "Open small terminal (30%)" })
end

return M
