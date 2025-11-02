function SetupColor(color)
  color = color or 'catppuccin-mocha'
  vim.cmd.colorscheme(color)

  -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('catppuccin').setup({
        no_italic = true,
      })
      SetupColor()
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    enabld = false,
    config = function()
      require('tokyonight').setup({})
      SetupColor()
    end,
  },
  {
    'rose-pine/neovim',
    priority = 1000,
    enabled = false,
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({})
      SetupColor()
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    priority = 1000,
    enabled = false,
    config = function()
      require('nordic').load()
      SetupColor()
    end,
  },
}
