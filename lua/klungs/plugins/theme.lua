return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
    priority = 1001, -- make sure to load this before all the other start plugins
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
    priority = 1001, -- make sure to load this before all the other start plugins
    enabled = false,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme('tokyonight-night')

      -- You can configure highlights by doing something like
      vim.cmd.hi('Comment gui=none')
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1001, -- make sure to load this before all the other start plugins
    enabled = false,
    init = function()
      vim.cmd.colorscheme('kanagawa-dragon')
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1001, -- make sure to load this before all the other start plugins
    enabled = false,
    init = function()
      require('onedark').setup({
        style = 'warmer',
      })
      vim.cmd.colorscheme('onedark')
    end,
  },
  {
    'rose-pine/neovim',
    priority = 1000,
    enable = true,
    name = 'rose-pine',
    init = function()
      vim.cmd.colorscheme('rose-pine')
    end,
  },
}
