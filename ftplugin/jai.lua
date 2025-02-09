-- Requires jails to be installed
--  See https://github.com/SogoCZE/Jails
vim.lsp.start({
  name = 'jai',
  cmd = { 'jails' },
  root_dir = vim.fn.getcwd(), -- Use PWD as project root dir.
})
