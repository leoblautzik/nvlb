-- Plantillas para archivos Python
local M = {}

M.setup = function()
  -- Archivos normales
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.py",
    callback = function()
      local filename = vim.fn.expand "%:t"
      if filename:match "^test_" or filename:match "_test%.py$" then return end

      vim.api.nvim_buf_set_lines(0, 0, 0, false, {
        "def main():",
        "    pass",
        "",
        'if __name__ == "__main__":',
        "    main()",
      })
      vim.api.nvim_win_set_cursor(0, {2,4})
    end,
  })

  -- Archivos de test
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "test_*.py", "*_test.py" },
    callback = function()
      local filepath = vim.fn.expand "%:p"
      local relative = filepath:gsub(vim.fn.getcwd() .. "/", "")
      local parts = vim.split(relative, "/")
      local dir = parts[#parts-1] or ""
      local file = parts[#parts] or ""
      file = file:gsub("%.py$", ""):gsub("^test_", ""):gsub("_test$", "")

      local function to_camel(s)
        local res = {}
        for word in string.gmatch(s, "[^_]+") do
          table.insert(res, word:sub(1,1):upper() .. word:sub(2))
        end
        return table.concat(res)
      end

      local class_name = "Test" .. to_camel(dir) .. to_camel(file)

      vim.api.nvim_buf_set_lines(0,0,0,false,{
        "import unittest",
        "",
        "class "..class_name.."(unittest.TestCase):",
        "    def test_example(self):",
        "        self.assertEqual(1+1,2)",
        "",
        "if __name__ == '__main__':",
        "    unittest.main()",
      })
      vim.api.nvim_win_set_cursor(0,{4,8})
    end,
  })
end

return M

