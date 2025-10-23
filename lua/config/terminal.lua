-- lua/config/terminal.lua
local M = {}

-- Floating terminal
M.open_floating = function()
  local buf = vim.api.nvim_create_buf(false, true)

  local function open_win()
    local width = math.floor(vim.o.columns * 0.85)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    return vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = row,
      col = col,
      style = 'minimal',
      border = 'rounded',
    })
  end

  local win = open_win()
  vim.fn.termopen(vim.o.shell)
  vim.cmd.startinsert()

  vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:q<CR>', { buffer = buf })

  -- Auto-resize
  vim.api.nvim_create_autocmd('VimResized', {
    buffer = buf,
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
      win = open_win()
      vim.cmd.startinsert()
    end,
  })
end

-- Small terminal (split inferior 30% con resize automático)
M.open_small = function()
  local function total_tab_height()
    local total = 0
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      total = total + vim.api.nvim_win_get_height(w)
    end
    return total
  end

  local total_before = total_tab_height()
  local term_h = math.max(3, math.floor(total_before * 0.3))

  vim.cmd(string.format('belowright %d split', term_h))
  vim.cmd.term(vim.o.shell)
  local term_win = vim.api.nvim_get_current_win()
  local term_buf = vim.api.nvim_get_current_buf()
  vim.cmd.startinsert()

  vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:close<CR>', { buffer = term_buf })

  local group_name = 'SmallTerm_' .. tostring(term_buf)
  vim.api.nvim_create_augroup(group_name, { clear = true })

  vim.api.nvim_create_autocmd({ 'VimResized', 'WinResized' }, {
    group = group_name,
    callback = function()
      if not vim.api.nvim_win_is_valid(term_win) then
        pcall(vim.api.nvim_del_augroup_by_name, group_name)
        return
      end
      local total = total_tab_height()
      local new_h = math.max(3, math.floor(total * 0.3))
      if vim.api.nvim_win_is_valid(term_win) then
        pcall(vim.api.nvim_win_set_height, term_win, new_h)
      end
    end,
  })
end

return M
