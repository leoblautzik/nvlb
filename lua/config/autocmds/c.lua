-- Plantillas para archivos C
local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.c",
    callback = function()
      vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        "#include <stdio.h>",
        "",
        "int main()",
        "{",
        "    return 0;",
        "}",
      })
      vim.api.nvim_win_set_cursor(0, {4,4})
    end,
  })
end

return M

