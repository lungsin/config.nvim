return {
  'numToStr/FTerm.nvim',
  config = function()
    -- local fterm = require('FTerm')
    -- fterm.setup({})

    vim.keymap.set('n', '<C-i>', '<CMD>lua require("FTerm").toggle()<CR>', { desc = 'Fterm: Toggle Terminal' })
    vim.keymap.set(
      't',
      '<C-i>',
      '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
      { desc = 'Fterm: Toggle Terminal' }
    )
  end,
}
