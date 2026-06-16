-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Remap increment/decrement if using <C-a> and <C-x>
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })

-- Remap redo so that <c-r> can be used for other mappings
vim.keymap.set('n', 'U', '<c-r>', { desc = 'Redo' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<c-esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode' })

-- Movement to handle word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window
vim.keymap.set('n', '<M-left>', '<c-w><left>', { desc = 'Focus window left' })
vim.keymap.set('n', '<M-right>', '<c-w><right>', { desc = 'Focus window right' })
vim.keymap.set('n', '<M-up>', '<c-w><up>', { desc = 'Focus window up' })
vim.keymap.set('n', '<M-down>', '<c-w><down>', { desc = 'Focus window down' })

vim.keymap.set('n', '<M-S-left>', '<c-w><', { desc = 'Focus window left' })
vim.keymap.set('n', '<M-S-right>', '<c-w>>', { desc = 'Focus window right' })
vim.keymap.set('n', '<M-S-up>', '<c-w>+', { desc = 'Focus window up' })
vim.keymap.set('n', '<M-S-down>', '<c-w>-', { desc = 'Focus window down' })

-- Save buffer
vim.keymap.set({ 'n', 'i' }, '<c-s>', '<cmd>w<cr>', { desc = 'Save buffer' })

-- Scrolling
vim.keymap.set('n', '<c-d>', '<c-d>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-e>', '10<c-e>')
vim.keymap.set('n', '<c-y>', '10<c-y>')
vim.keymap.set('n', '<c-s-e>', '<c-e>')
vim.keymap.set('n', '<c-s-y>', '<c-y>')

-- Visual mode
-- Use <C-r> to insert the v:count1 to commandline mode
vim.keymap.set('x', 'J', [[:m '>+<C-r>=v:count1<CR><CR>gv=gv]], { desc = 'Move selection down' })
vim.keymap.set('x', 'K', [[:m '<-<C-r>=v:count1+1<CR><CR>gv=gv]], { desc = 'Move selection up' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent selection right' })
vim.keymap.set('x', '<', '<gv', { desc = 'Indent selection left' })

-- Copy/Cut/Paste quality of life
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste and keep it available for further pasting' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without changing clipboard' })

-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
vim.keymap.set('n', '[p', '<Cmd>exe "put! " . v:register<CR>', { desc = 'Paste Above' })
vim.keymap.set('n', ']p', '<Cmd>exe "put "  . v:register<CR>', { desc = 'Paste Below' })

-- UI related stuff
vim.keymap.set('n', '<leader>uw', function() vim.o.wrap = not vim.o.wrap end, { desc = 'Toggle line wrap' })
