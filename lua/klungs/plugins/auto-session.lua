return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>Qr', '<cmd>AutoSession restore<CR>', desc = 'Restore session' },
    { '<leader>Qd', '<cmd>AutoSession delete<CR>', desc = 'Delete session' },
    { '<leader>Qs', '<cmd>AutoSession search<CR>', desc = 'Search session' },
    { '<leader>Qr', '<cmd>restart<CR>', desc = 'Restart' },
    { '<leader>Qq', '<cmd>wqa<CR>', desc = 'Quit' },
  },
  opts = {
    log_level = 'error',
    auto_session_suppress_dirs = { '~/' },
  },
}
