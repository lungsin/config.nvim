-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
--
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Copy/Cut/Paste quality of life
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste and keep it available for further pasting' })

-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
-- vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank entire line to system clipboard' })
