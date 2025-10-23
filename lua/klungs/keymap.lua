-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '<c-q>', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<c-esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })

-- Window
vim.keymap.set('n', '<M-left>', '<c-w><left>', { desc = 'Focus window left' })
vim.keymap.set('n', '<M-right>', '<c-w><right>', { desc = 'Focus window right' })
vim.keymap.set('n', '<M-up>', '<c-w><up>', { desc = 'Focus window up' })
vim.keymap.set('n', '<M-down>', '<c-w><down>', { desc = 'Focus window down' })

-- Scrolling
vim.keymap.set('n', '<c-d>', '<c-d>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-e>', '10<c-e>')
vim.keymap.set('n', '<c-y>', '10<c-y>')

-- Visual mode
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent selection right' })
vim.keymap.set('x', '<', '<gv', { desc = 'Indent selection left' })

-- Copy/Cut/Paste quality of life
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste and keep it available for further pasting' })
-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
vim.keymap.set('n', '[p', '<Cmd>exe "put! " . v:register<CR>', { desc = 'Paste Above' })
vim.keymap.set('n', ']p', '<Cmd>exe "put "  . v:register<CR>', { desc = 'Paste Below' })
