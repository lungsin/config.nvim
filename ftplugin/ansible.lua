vim.keymap.set(
  'v',
  '<leader>vr',
  function() require('ansible').run() end,
  { buffer = true, silent = true, desc = 'Ansible run' }
)
vim.keymap.set(
  'n',
  '<leader>vr',
  ":w<CR> :lua require('ansible').run()<CR>",
  { buffer = true, silent = true, desc = 'Ansible run' }
)
