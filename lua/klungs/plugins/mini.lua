return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    local extra = require('mini.extra')
    local ai = require('mini.ai')
    ai.setup({
      custom_textobjects = {
        g = extra.gen_ai_spec.buffer(),
        D = extra.gen_ai_spec.diagnostic(),
        I = extra.gen_ai_spec.indent(),
        N = extra.gen_ai_spec.number(),
        F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        A = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
        L = ai.gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
        e = ai.gen_spec.treesitter({ a = '@assignment.rhs', i = '@assignment.lhs' }),
        E = ai.gen_spec.treesitter({ a = '@assignment.outer', i = '@assignment.inner' }),
      },
    })
    require('mini.extra').setup()
    require('mini.surround').setup()
    require('mini.icons').setup({
      extension = {
        ['jai'] = { glyph = 'J' },
      },
    })
  end,
}
