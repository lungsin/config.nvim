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

-- Arrow keys move by display line for small counts, by real line for large counts
vim.keymap.set({ 'n', 'x' }, '<up>', "v:count < 5 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<down>', "v:count < 5 ? 'gj' : 'j'", { expr = true, silent = true })

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
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<c-s>', '<cmd>w<cr>', { desc = 'Save buffer' })

-- Scrolling
vim.keymap.set('n', '<c-d>', '<c-d>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { desc = 'Half-page scroll down and center cursor' })
vim.keymap.set('n', '<c-e>', '7<c-e>')
vim.keymap.set('n', '<c-y>', '7<c-y>')
vim.keymap.set('n', '<c-s-e>', '7<c-e>7j')
vim.keymap.set('n', '<c-s-y>', '7<c-y>7k')

-- Visual mode
-- Use <C-r> to insert the v:count1 to commandline mode
vim.keymap.set('x', 'J', [[:m '>+<C-r>=v:count1<CR><CR>gv=gv]], { desc = 'Move selection down' })
vim.keymap.set('x', 'K', [[:m '<-<C-r>=v:count1+1<CR><CR>gv=gv]], { desc = 'Move selection up' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent selection right' })
vim.keymap.set('x', '<', '<gv', { desc = 'Indent selection left' })

-- Yank current buffer path to clipboard
vim.keymap.set('n', '<leader>yp', function()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  vim.fn.setreg('+', path)
  vim.notify('Yanked: ' .. path)
end, { desc = 'Yank relative buffer path' })

vim.keymap.set('n', '<leader>yP', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Yanked: ' .. path)
end, { desc = 'Yank absolute buffer path' })

vim.keymap.set('n', '<leader>yl', function()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  local location = string.format('%s:%d', path, vim.fn.line('.'))
  vim.fn.setreg('+', location)
  vim.notify('Yanked: ' .. location)
end, { desc = 'Yank cursor location' })

vim.keymap.set('x', '<leader>yl', function()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  local s, e = vim.fn.line('v'), vim.fn.line('.')
  if s > e then
    s, e = e, s
  end
  local location = s == e and string.format('%s:%d', path, s) or string.format('%s:%d-%d', path, s, e)
  vim.fn.setreg('+', location)
  vim.notify('Yanked: ' .. location)
  vim.api.nvim_feedkeys(vim.keycode('<esc>'), 'n', false)
end, { desc = 'Yank selection range' })

-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
vim.keymap.set('n', '[p', '<Cmd>exe "put! " . v:register<CR>', { desc = 'Paste Above' })
vim.keymap.set('n', ']p', '<Cmd>exe "put "  . v:register<CR>', { desc = 'Paste Below' })

-- commenting
vim.keymap.set('n', '<c-/>', 'gcc', { remap = true, desc = 'Toggle Comment' })
vim.keymap.set('x', '<c-/>', 'gc', { remap = true, desc = 'Toggle Comment' })
vim.keymap.set('o', '<c-/>', 'gc', { remap = true, desc = 'Comment textobject' })
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- UI related stuff
vim.keymap.set('n', '<leader>uw', function() vim.o.wrap = not vim.o.wrap end, { desc = 'Toggle line wrap' })
