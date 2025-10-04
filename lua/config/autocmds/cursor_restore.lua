-- Restaurar última posición del cursor y scroll
local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
      if vim.tbl_contains({ "gitcommit", "gitrebase" }, vim.bo.filetype) then return end
      if vim.fn.line [["]] > 0 and vim.fn.line [["]] <= vim.fn.line "$" then
        vim.fn.setpos(".", vim.fn.getpos [["]])
        vim.cmd "normal! zv"
      end
      local view = vim.fn.winsaveview()
      vim.schedule(function() 
          vim.fn.winrestview(view) 
      end)
    end,
  })
end

return M

