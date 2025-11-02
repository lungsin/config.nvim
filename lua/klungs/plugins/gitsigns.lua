return {
  -- See `:help gitsigns` to understand what the configuration keys do
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame = true,
    gh = true,
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          ---@diagnostic disable-next-line: param-type-mismatch
          gitsigns.nav_hunk('next')
        end
      end, { desc = 'Jump to next git change' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          ---@diagnostic disable-next-line: param-type-mismatch
          gitsigns.nav_hunk('prev')
        end
      end, { desc = 'Jump to previous git change' })

      -- Actions
      -- visual mode
      map(
        'v',
        '<leader>hs',
        function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = 'stage git hunk' }
      )
      map(
        'v',
        '<leader>hr',
        function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = 'reset git hunk' }
      )
      -- Normal mode
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git Stage/Un-stage Hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git reset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git Stage buffer' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git Reset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git preview hunk' })
      map('n', '<leader>hP', gitsigns.preview_hunk_inline, { desc = 'Toggle git show Deleted' })
      map('n', '<leader>hb', gitsigns.blame_line, { desc = 'Git blame line' })
      map('n', '<leader>hB', gitsigns.toggle_current_line_blame, { desc = 'Toggle Git blame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git diff against index' })
      -- -@diagnostic disable-next-line: param-type-mismatch
      map('n', '<leader>hD', function() gitsigns.diffthis('@') end, { desc = 'Git Diff against last commit' })
      -- Toggles
    end,
  },
}
