-- register all text objects with which-key
local function ai_whichkey()
  ---@type table<string, string>
  local spec = {
    [' '] = 'Whitespace',
    ['"'] = 'Balanced "',
    ["'"] = "Balanced '",
    ['`'] = 'Balanced `',
    ['('] = 'Balanced (',
    [')'] = 'Balanced ) including white-space',
    ['>'] = 'Balanced > including white-space',
    ['<lt>'] = 'Balanced <',
    [']'] = 'Balanced ] including white-space',
    ['['] = 'Balanced [',
    ['}'] = 'Balanced } including white-space',
    ['{'] = 'Balanced {',
    ['?'] = 'User Prompt',
    _ = 'Underscore',
    a = 'Argument',
    A = 'Argument ()',
    b = 'Balanced ), ], }',
    c = 'Class',
    d = 'Diagnostic',
    f = 'Function',
    g = 'Entire file',
    i = 'Indent',
    N = 'Number',
    o = 'Block, conditional, loop',
    q = 'Quote `, ", \'',
    t = 'Tag',
    u = 'Use/call function & method',
    U = 'Use/call without dot in name',
  }
  local m = {}

  local ai_opts = { a = 'Around', i = 'Inside' }
  local np_opts = { n = 'Next', p = 'Prev' }
  -- setup textobject
  for k, v in pairs(spec) do
    for ai in pairs(ai_opts) do
      local desc = (ai == 'i' and v) or v:gsub(' including.*', '')
      table.insert(m, { ai .. k, desc = desc })
      for np in pairs(np_opts) do
        table.insert(m, { ai .. np .. k, desc = desc })
      end
    end
  end

  -- setup groups
  for ai, ai_desc in pairs(ai_opts) do
    table.insert(m, { ai, group = ai_desc })
    for np, np_desc in pairs(np_opts) do
      table.insert(m, { ai .. np, group = np_desc })
    end
  end

  require('which-key').add({ mode = { 'o', 'x' }, m })
end

return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function(s, b)
    local extra = require('mini.extra')
    local ai = require('mini.ai')
    ai.setup({
      custom_textobjects = {
        A = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
        d = extra.gen_ai_spec.diagnostic(),
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        g = extra.gen_ai_spec.buffer(),
        N = extra.gen_ai_spec.number(),
        o = ai.gen_spec.treesitter({ -- code block
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }),
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags (regex from LazyVim)
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
      },
    })
    require('klungs.util').on_load('which-key.nvim', function() vim.schedule(ai_whichkey) end)
    require('mini.extra').setup()
    require('mini.surround').setup({
      custom_surrounding = {
        -- Swap the default behaviour of the brackets to make it more consistent with mini.ai brackets textobject.
        -- Opening bracket doesn't include padding and closing bracket include padding.
        ['('] = { output = { left = '(', right = ')' } },
        [')'] = { output = { left = '( ', right = ' )' } },
        ['['] = { output = { left = '[', right = ']' } },
        [']'] = { output = { left = '[ ', right = ' ]' } },
        ['{'] = { output = { left = '{', right = '}' } },
        ['}'] = { output = { left = '{ ', right = ' }' } },
        ['<'] = { output = { left = '<', right = '>' } },
        ['>'] = { output = { left = '< ', right = ' >' } },
      },
    })
    require('mini.icons').setup({
      extension = {
        ['jai'] = { glyph = 'J' },
      },
    })
    require('mini.diff').setup({
      view = {
        style = 'sign',
        signs = {
          add = '▎',
          change = '▎',
          delete = '',
        },
      },
    })
  end,
  keys = {
    {
      '<leader>go',
      function() require('mini.diff').toggle_overlay(0) end,
      desc = 'Toggle mini.diff overlay',
    },
  },
}
