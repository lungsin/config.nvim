return {
  -- *** smooth scrolling
  'karb94/neoscroll.nvim',
  event = { 'BufRead', 'InsertEnter' },
  -- Disable neoscroll when neovide is enabled to avoid conflicts
  enabled = not vim.g.neovide,
  config = function()
    local neoscroll = require('neoscroll')
    local keymap = {
      -- scroll full page:
      ['<C-b>'] = function() neoscroll.ctrl_b({ duration = 300 }) end, -- 450 default
      ['<C-f>'] = function() neoscroll.ctrl_f({ duration = 300 }) end, -- 450 default
      --
      -- scroll half page:
      ['<C-u>'] = function() neoscroll.ctrl_u({ duration = 150 }) end, -- 250 default
      ['<C-d>'] = function() neoscroll.ctrl_d({ duration = 150 }) end, -- 250 default

      -- scroll a "few" line(s):
      -- Using relative scrolls instead of absolute scrolls
      ['<C-y>'] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 50 }) end, -- 100 default
      ['<C-e>'] = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 50 }) end, -- 100 default (feels slow)
      -- FYI love move_cursor param! allows me to use original C-e/y design and have a scrollunder variant:
      ['<C-S-y>'] = function() neoscroll.scroll(-0.1, { move_cursor = true, duration = 50 }) end, -- 100 default
      ['<C-S-e>'] = function() neoscroll.scroll(0.1, { move_cursor = true, duration = 50 }) end, -- 100 default (feels slow)
      -- FYI neoscroll is more than just about smooth scroll, it's a tool to design all sorts of scrolls

      --
      -- scroll cursor line to top/middle/bottom:
      ['zt'] = function() neoscroll.zt({ half_win_duration = 150 }) end, -- 250 half_win_duration default
      ['zz'] = function() neoscroll.zz({ half_win_duration = 150 }) end, -- 250 half_win_duration default
      ['zb'] = function() neoscroll.zb({ half_win_duration = 150 }) end, -- 250 half_win_duration default
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
    neoscroll.setup({
      -- Disable all default mappings
      mappings = {},
      easing = 'sine',
      hide_cursor = true, -- Make the scroll animation less crowded
    })
  end,
}
