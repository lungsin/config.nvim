return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>hf', '<cmd>DiffviewFileHistory<CR>', desc = 'Diff: Repo history' },
    { '<leader>hF', '<cmd>DiffviewFileHistory --follow %<CR>', desc = 'Diff: File history' },
    { '<leader>hl', mode = 'x', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", desc = 'Diff: Range history' },
    { '<leader>hh', '<Cmd>DiffviewOpen<CR>', desc = 'Diff: Repo diff' },
    { '<leader>hq', '<Cmd>DiffviewClose<CR>', desc = 'Diff: close diff view' },
  },
}
