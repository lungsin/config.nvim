-- Detect tabstop and shiftwidth automatically
return {
  -- Note: Consider use 'tpope/vim-sleuth' if not enough
  'NMAC427/guess-indent.nvim',
  lazy = false,
  opts = {},
  keys = {
    { '<leader>ui', '<cmd>GuessIndent<cr>', desc = 'Detect indent' },
  },
}
