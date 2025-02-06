return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  config = function()
    vim.keymap.set('n', '<leader>tS', '<cmd>Sleuth<cr>', { desc = 'Trigger sleuth: adjust indent width' })
  end,
}
