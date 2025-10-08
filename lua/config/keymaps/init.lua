-- Cargar todos los keymaps
local modules = { 'base', 'runner', 'terminal' }

for _, mod in ipairs(modules) do
  local ok, m = pcall(require, 'config.keymaps.' .. mod)
  if ok and m.setup then
    m.setup()
  end
end
