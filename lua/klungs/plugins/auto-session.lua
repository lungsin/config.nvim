return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>qR', '<cmd>AutoSession restore<CR>', desc = 'Restore session' },
    { '<leader>qd', '<cmd>AutoSession delete<CR>', desc = 'Delete session' },
    { '<leader>qs', '<cmd>AutoSession search<CR>', desc = 'Search session' },
    { '<leader>qr', '<cmd>restart<CR>', desc = 'Restart' },
    { '<leader>qq', '<cmd>wqa<CR>', desc = 'Quit' },
  },
  opts = {
    log_level = 'error',
    auto_session_suppress_dirs = { '~/' },
  },
}
