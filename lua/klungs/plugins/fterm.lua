return {
  'numToStr/FTerm.nvim',
  config = function()
    -- local fterm = require('FTerm')
    -- fterm.setup({})

    vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', { desc = 'Fterm: Toggle Terminal' })
    vim.keymap.set(
      't',
      '<A-i>',
      '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
      { desc = 'Fterm: Toggle Terminal' }
    )
  end,
}
