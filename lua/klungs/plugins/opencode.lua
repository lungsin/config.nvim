local opencode_cmd = 'opencode --port'
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = 'right',
    enter = false,
  },
}

return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim', -- Requires input, picker, terminal modules (configured in snacks.lua)
  },
  enabled = true,
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function() require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts) end,
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    local keymap_set = require('klungs.utils').keymap_set

    keymap_set(
      { 'n', 'x' },
      -- '<c-k>', -- Using Cursor's mapping
      '<c-a>',
      function()
        require('opencode').command('session.new')
        require('opencode').ask('@this: ')
      end,
      { desc = 'Ask opencode in new session' }
    )
    keymap_set(
      { 'n', 'x' },
      '<leader>aa',
      function() require('opencode').ask('@this: ') end,
      { desc = 'Ask opencode in new session' }
    )

    keymap_set(
      { 'n', 'x' },
      { '<c-x>', '<leader>ax' },
      function() require('opencode').select() end,
      { desc = 'Execute opencode action…' }
    )
    keymap_set(
      { 'n', 't' },
      '<C-.>',
      function() require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts) end,
      { desc = 'Toggle opencode' }
    )

    keymap_set(
      { 'n', 'x' },
      'go',
      function() return require('opencode').operator('@this ') end,
      { desc = 'Append range to OpenCode', expr = true }
    )
    keymap_set(
      'n',
      'goo',
      function() return require('opencode').operator('@this ') .. '_' end,
      { desc = 'Append line to OpenCode', expr = true }
    )

    -- Command: navigation
    keymap_set(
      'n',
      '<S-C-u>',
      function() require('opencode').command('session.half.page.up') end,
      { desc = 'opencode half page up' }
    )
    keymap_set(
      'n',
      '<S-C-d>',
      function() require('opencode').command('session.half.page.down') end,
      { desc = 'opencode half page down' }
    )

    -- Command: Clear / Submit prompt
    keymap_set(
      'n',
      '<leader>ac',
      function() require('opencode').command('prompt.clear') end,
      { desc = 'opencode clear prompt' }
    )

    keymap_set(
      'n',
      { '<leader>a<enter>', '<leader>as' },
      function() require('opencode').command('prompt.submit') end,
      { desc = 'opencode submit prompt' }
    )

    -- Remap increment/decrement if using <C-a> and <C-x> for opencode
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  end,
}
