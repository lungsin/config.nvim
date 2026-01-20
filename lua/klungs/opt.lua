-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.g.clipboard = 'osc52'

-- Enable break indent
vim.opt.breakindent = true

-- Enable smart indent for C-like program
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')

vim.opt.colorcolumn = '120'

-- Disable word wrap
vim.opt.wrap = false
-- But in case I enabled it manually, breaks by word rather than character
vim.opt.linebreak = true

-- Jumplist
vim.o.jumpoptions = 'stack'

-- Fold
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''
-- vim.opt.foldcolumn = '3'
vim.opt.foldlevelstart = 99
vim.opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldclose = '',
  foldopen = '',
  foldsep = ' ',
}

-- Cmdline completion (as fallback in case blink completion is disabled)
vim.opt.wildmode = 'longest:full,full'

-- Diff
vim.opt.diffopt = 'filler,internal,closeoff,algorithm:histogram,context:5,linematch:60'

-- Cursor
vim.opt.guicursor = table.concat({
  'n-v-c-sm:block',
  'i-ci-ve:ver25',
  'r-cr-o:hor20',
  't:ver25-blinkon500-blinkoff500-TermCursor',
}, ',')
