return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-mini/mini.nvim' },
  opts = {
    sections = {
      lualine_c = {
        { 'filename', path = 1 },
      },
    },
  },
}
