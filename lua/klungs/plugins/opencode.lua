return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim', -- Requires input, picker, terminal modules (configured in snacks.lua)
  },
  enabled = true,
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended keymaps
    vim.keymap.set(
      { 'n', 'x' },
      '<c-k>', -- Using Cursor's mapping
      function() require('opencode').ask('@this: ', { submit = true }) end,
      { desc = 'Ask opencode' }
    )
    vim.keymap.set(
      { 'n', 'x' },
      '<leader>aa',
      function() require('opencode').select() end,
      { desc = 'Execute opencode action…' }
    )
    vim.keymap.set({ 'n', 't' }, '<C-.>', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ai',
      function() return require('opencode').operator('@this \n') end,
      { expr = true, desc = 'Add range to opencode' }
    )
    vim.keymap.set(
      'n',
      '<leader>aii',
      function() return require('opencode').operator('@this \n') .. '_' end,
      { expr = true, desc = 'Add line to opencode' }
    )

    -- Command: navigation
    vim.keymap.set(
      'n',
      '<S-C-u>',
      function() require('opencode').command('session.half.page.up') end,
      { desc = 'opencode half page up' }
    )
    vim.keymap.set(
      'n',
      '<S-C-d>',
      function() require('opencode').command('session.half.page.down') end,
      { desc = 'opencode half page down' }
    )

    -- Command: Clear / Submit prompt
    vim.keymap.set(
      'n',
      '<leader>ac',
      function() require('opencode').command('prompt.clear') end,
      { desc = 'opencode clear prompt' }
    )

    vim.keymap.set(
      'n',
      '<leader>as',
      function() require('opencode').command('prompt.submit') end,
      { desc = 'opencode submit prompt' }
    )

    -- Remap increment/decrement if using <C-a> and <C-x> for opencode
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  end,
}
