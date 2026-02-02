return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>ww', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    { '<leader>wd', '<cmd>AutoSession delete<CR>', desc = 'Delete session' },
    { '<leader>wr', '<cmd>AutoSession restore<CR>', desc = 'Restore session' },
    { '<leader>ws', '<cmd>AutoSession search<CR>', desc = 'Search session' },
    { '<leader>wq', '<cmd>wqa<CR>', desc = 'Quit' },
  },
  opts = {
    log_level = 'error',
    auto_session_suppress_dirs = { '~/' },
  },
}
