-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<c-esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<c-d>', '<c-d>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-e>', '10<c-e>')
vim.keymap.set('n', '<c-y>', '10<c-y>')

-- Visual mode
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Copy/Cut/Paste quality of life
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste and keep it available for further pasting' })
-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
vim.keymap.set('n', '[p', '<Cmd>exe "put! " . v:register<CR>', { desc = 'Paste Above' })
vim.keymap.set('n', ']p', '<Cmd>exe "put "  . v:register<CR>', { desc = 'Paste Below' })

-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
-- vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank entire line to system clipboard' })
