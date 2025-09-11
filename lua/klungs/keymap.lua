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
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-d>', '20jzz')
vim.keymap.set('n', '<C-u>', '20kzz')

-- Visual mode
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Copy/Cut/Paste quality of life
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste and keep it available for further pasting' })

-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
-- vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank entire line to system clipboard' })
