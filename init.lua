-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Custom config to indicate that nerd font is installed
vim.g.have_nerd_font = true
-- Custom config to indicate which picker to choose
---@type "telescope" | "fzf-lua"
vim.g.picker = 'telescope'

require('klungs')
