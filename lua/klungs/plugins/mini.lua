return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    local extra = require('mini.extra')
    local ai = require('mini.ai')
    ai.setup({
      custom_textobjects = {
        B = extra.gen_ai_spec.buffer(),
        D = extra.gen_ai_spec.diagnostic(),
        I = extra.gen_ai_spec.indent(),
        L = extra.gen_ai_spec.line(),
        N = extra.gen_ai_spec.number(),
        F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
      },
    })
    require('mini.extra').setup()
    require('mini.surround').setup()
  end,
}
