-- =========================================================
-- NVLB Snippets personalizados - C / Python / Go
-- Compatible con LuaSnip + nvim-cmp
-- =========================================================

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

-- =========================================================
-- 🧠 SNIPPETS EN C
-- =========================================================
ls.add_snippets('c', {
  s(
    'main',
    fmt(
      [[
    #include <stdio.h>
    #include <stdlib.h>

    int main(int argc, char *argv[]) {{
        {}
        return 0;
    }}
  ]],
      { i(0) }
    )
  ),

  s(
    'fori',
    fmt(
      [[
    for (int {idx} = 0; {idx} < {limit}; {idx}++) {{
        {}
    }}
  ]],
      { idx = i(1, 'i'), limit = i(2, 'n'), i(0) }
    )
  ),

  s(
    'printf',
    fmt([[printf("{}\n"{vars});]], {
      i(1, 'mensaje'),
      vars = i(0, ''),
    })
  ),
})

-- =========================================================
-- 🐍 SNIPPETS EN PYTHON
-- =========================================================
ls.add_snippets('python', {
  s(
    'main',
    fmt(
      [[
    def main():
        {}
        
    if __name__ == "__main__":
        main()
  ]],
      { i(0) }
    )
  ),

  s(
    'fori',
    fmt(
      [[
    for {var} in range({limit}):
        {}
  ]],
      { var = i(1, 'i'), limit = i(2, 'n'), i(0) }
    )
  ),

  s(
    'print',
    fmt([[print("{}"{} )]], {
      i(1, 'mensaje'),
      i(0),
    })
  ),
})

-- =========================================================
-- 🦦 SNIPPETS EN GO
-- =========================================================
ls.add_snippets('go', {
  s(
    'main',
    fmt(
      [[
    package main

    import "fmt"

    func main() {{
        {}
    }}
  ]],
      { i(0) }
    )
  ),

  s(
    'func',
    fmt(
      [[
    func {name}({params}) {rettype} {{
        {}
    }}
  ]],
      {
        name = i(1, 'nombreFuncion'),
        params = i(2, ''),
        rettype = i(3, ''),
        i(0),
      }
    )
  ),

  s(
    'iferr',
    fmt(
      [[
    if err != nil {{
        return {ret}
    }}
  ]],
      { ret = i(0, 'err') }
    )
  ),
})

-- =========================================================
-- ⚙️ OPCIONAL: Atajos globales para re-cargar snippets
-- =========================================================
vim.keymap.set('n', '<leader>rs', function()
  require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath 'config' .. '/lua' }
  print 'Snippets recargados!'
end, { desc = 'Recargar snippets NVLB' })
