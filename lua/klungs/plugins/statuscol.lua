return {
  'luukvbaal/statuscol.nvim',
  enabled = false,
  config = function()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      relculright = true,
      segments = {
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
        { sign = { namespace = { 'gitsign*' } }, click = 'v:lua.ScSa' },
        {
          sign = { namespace = { 'diagnostic/signs' }, maxwidth = 2, auto = true },
          click = 'v:lua.ScSa',
        },
        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
        {
          sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = 'v:lua.ScSa',
        },
      },
    })
  end,
}
