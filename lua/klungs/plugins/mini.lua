return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    -- require('mini.extra').setup()
    -- require('mini.pick').setup()
    require('mini.surround').setup()
  end,
}
