---@module "lazy"
---@type LazySpec
return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    keys = {
      {
        '>',
        function() require('quicker').expand({ before = 2, after = 2, add_to_existing = true }) end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function() require('quicker').collapse() end,
        desc = 'Collapse quickfix context',
      },
    },
  },
  keys = {
    { '<leader>cq', function() require('quicker').toggle() end, desc = 'Toggle quickfix' },
    { '<leader>cl', function() require('quicker').toggle({}) end, desc = 'Toggle loclist' },
    -- Diagnostic keymaps
    -- { '<c-q>', vim.diagnostic.setloclist, desc = 'Open diagnostic Quickfix list' },
    { '<leader>cd', vim.diagnostic.open_float, desc = 'Line Diagnostics' },
  },
}
