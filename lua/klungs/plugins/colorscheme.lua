return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
      })

      -- setup must be called before loading
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = false,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme('tokyonight-night')

      -- You can configure highlights by doing something like
      -- vim.cmd.hi('Comment gui=none')
    end,
  },
  {
    'rose-pine/neovim',
    priority = 1000,
    enabled = false,
    name = 'rose-pine',
    init = function()
      vim.cmd.colorscheme('rose-pine')
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require('nordic').load()
    end,
  },
}
