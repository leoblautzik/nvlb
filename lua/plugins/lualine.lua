local function modified_indicator()
  if vim.bo.modified then
    return '●' -- o cualquier símbolo que quieras
  else
    return '✓' -- buffer guardado
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- opcional pero recomendado
  config = function()
    ---@diagnostic disable-next-line: undefined-field
    require('lualine').setup {
      options = {
        --theme = "catppuccin", -- usa el tema automáticamente
        globalstatus = false, -- single bar para todo el layout
        section_separators = { right = '', left = '' },
        component_separators = '', -- { left = "", right = "" },
      },
      sections = {
        lualine_a = { { 'mode', icon = '', separator = { left = '', right = '' }, right_padding = 1 } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { modified_indicator }, 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = {
          -- {
          --   function()
          --     local dir = vim.fn.expand '%:p:h'
          --     local parts = vim.split(dir, '/')
          --     local short_parts = {}
          --
          --     -- Tomar solo los últimos tres niveles
          --     local start = math.max(1, #parts - 2)
          --     local last_parts = vim.list_slice(parts, start, #parts)
          --
          --     for i, part in ipairs(last_parts) do
          --       if part ~= '' then
          --         if i < #last_parts then
          --           table.insert(short_parts, string.sub(part, 1, 2)) -- abrevia
          --         else
          --           table.insert(short_parts, part) -- último completo
          --         end
          --       end
          --     end
          --
          --     return table.concat(short_parts, '/')
          --   end,
          --   icon = '', -- iconito de carpeta
          -- },
          'progress',
        },
        lualine_z = { { 'location', separator = { left = '', right = '' }, left_padding = 1 } },
      },
    }
  end,
}
