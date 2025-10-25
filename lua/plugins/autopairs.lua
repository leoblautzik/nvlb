return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local autopairs = require 'nvim-autopairs'
    autopairs.setup {}

    -- -- Integración con blink.cmp
    -- local ok_blink, blink = pcall(require, 'blink.cmp')
    -- if ok_blink and blink.on_confirm_done then
    --   local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    --   blink.on_confirm_done(cmp_autopairs.on_confirm_done())
    -- end
  end,
}
