-- Requires jails to be installed
--  See https://github.com/SogoCZE/Jails
---@type vim.lsp.Config
return {
  name = 'jails',
  cmd = { 'jails' },
  root_dir = vim.fn.getcwd(), -- Use PWD as project root dir.
}
