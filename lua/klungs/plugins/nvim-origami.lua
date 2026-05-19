return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  opts = {
    useLspFoldsWithTreesitterFallback = { enabled = false },
    foldtext = {
      lineCount = {
        template = ' %d',
      },
    },
    foldKeymaps = {
      setup = false,
    },
  },
  init = function()
    -- Fold options
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    -- Fallback to indent, overriden by treesitter if available
    -- Check out lua/klungs/plugins/treesitter.lua
    vim.opt.foldmethod = 'indent'
    vim.opt.fillchars = {
      foldopen = '',
      foldclose = '',
      fold = ' ',
      foldsep = ' ',
      foldinner = ' ',
      diff = '╱',
      eob = ' ',
    }
  end,
}
