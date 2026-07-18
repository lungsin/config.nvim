-- Inherit most settings from jsonc.
vim.cmd('runtime! ftplugin/jsonc.vim')
vim.cmd('runtime! indent/jsonc.vim')

-- We anyway use the json parser for jsonc, this replicates the logic for hujson.
vim.treesitter.language.register('json', 'hujson')
