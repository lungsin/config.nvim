---@module "lazy"
---@type LazySpec
return {
  'esmuellert/codediff.nvim',
  cmd = 'CodeDiff',
  opts = {
    explorer = {
      view_mode = 'tree',
    },
    history = {
      view_mode = 'tree',
    },
    keymaps = {
      view = {
        next_file = '<C-Down>',
        prev_file = '<C-Up>',
      },
    },
  },
  keys = {
    { '<leader>hd', '<cmd>CodeDiff<cr>', desc = 'CodeDiff changes' },
    { '<leader>hf', '<cmd>CodeDiff file HEAD<cr>', desc = 'CodeDiff file vs HEAD' },
    {
      '<leader>hm',
      function()
        local ref = vim.fn.systemlist('git rev-parse --abbrev-ref origin/HEAD')[1]
        if vim.v.shell_error ~= 0 or not ref then
          ref = 'main'
        end
        vim.cmd('CodeDiff ' .. ref .. '...')
      end,
      desc = 'CodeDiff vs default branch (merge base)',
    },
    { '<leader>hh', '<cmd>CodeDiff history<cr>', desc = 'CodeDiff history' },
    { '<leader>hH', '<cmd>CodeDiff history %<cr>', desc = 'CodeDiff file history' },
    { '<leader>hh', ':CodeDiff history<cr>', mode = 'x', desc = 'CodeDiff selection history' },
  },
}
