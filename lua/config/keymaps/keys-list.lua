local M = {}
M.setup = function()
  local function list_leader_keymaps()
    local keymaps = vim.api.nvim_get_keymap 'n'
    local leader = vim.g.mapleader or '\\'
    local grouped = {}

    -- Agrupa por primer carácter después de <leader>
    for _, km in ipairs(keymaps) do
      if km.desc and km.lhs:sub(1, 1) == leader then
        local group_key = km.lhs:sub(2, 2) or 'otros'
        if not grouped[group_key] then
          grouped[group_key] = {}
        end
        table.insert(grouped[group_key], { lhs = km.lhs, desc = km.desc })
      end
    end

    -- Mostrar por grupos ordenados
    print '==== Keymaps con <leader> ===='
    local keys = {}
    for k in pairs(grouped) do
      table.insert(keys, k)
    end
    table.sort(keys)

    for _, k in ipairs(keys) do
      print('Grupo ' .. k .. ':')
      table.sort(grouped[k], function(a, b)
        return a.lhs < b.lhs
      end)
      for _, km in ipairs(grouped[k]) do
        print('  ' .. km.lhs .. ' -> ' .. km.desc)
      end
    end
  end

  -- Exponer la función globalmente para poder llamarla fácilmente
  _G.list_leader_keymaps = list_leader_keymaps

  vim.keymap.set('n', '<leader>hk', ':lua list_leader_keymaps()<CR>', { desc = 'Mostrar keymaps con <leader>' })
end
return M
