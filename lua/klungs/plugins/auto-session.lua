return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>qw', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    { '<leader>qd', '<cmd>AutoSession delete<CR>', desc = 'Delete session' },
  },
  config = function()
    require('auto-session').setup({
      log_level = 'error',
      auto_session_suppress_dirs = { '~/' },
    })
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
  end,
}
