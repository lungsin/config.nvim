---@module "fzf-lua"
---@module "lazy"

---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  enabled = true,
  priority = 1000,
  lazy = false,
  dependencies = {
    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {},
  keys = {
    { '<leader><space>', function() FzfLua.files() end, desc = 'Smart Find Files' },
    { '<leader>,', function() FzfLua.buffers({ sort_lastused = true }) end, desc = 'Buffers' },
    { '<leader>/', function() FzfLua.live_grep() end, desc = 'Live Grep' },
    { '<leader>:', function() FzfLua.command_history() end, desc = 'Command History' },
    -- find
    { '<leader>fb', function() FzfLua.buffers({ sort_lastused = true }) end, desc = 'Buffers' },
    { '<leader>fc', function() FzfLua.files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Find Config File' },
    { '<leader>ff', function() FzfLua.files() end, desc = 'Find Files' },
    { '<leader>fF', function() FzfLua.files({ cwd = vim.uv.cwd() }) end, desc = 'Find File (cwd)' },
    { '<leader>fg', function() FzfLua.git_files() end, desc = 'Find Git Files' },
    { '<leader>fr', function() FzfLua.oldfiles() end, desc = 'Recent' },
    -- git
    { '<leader>gb', function() FzfLua.git_branches() end, desc = 'Git Branches' },
    { '<leader>gc', function() FzfLua.git_commits() end, desc = 'Git Commits (Project)' },
    { '<leader>gC', function() FzfLua.git_bcommits() end, desc = 'Git Commits (Buffer)' },
    { '<leader>gs', function() FzfLua.git_status() end, desc = 'Git Status' },
    { '<leader>gS', function() FzfLua.git_stash() end, desc = 'Git Stash' },
    { '<leader>gd', function() FzfLua.git_diff() end, desc = 'Git Diff (Hunks)' },
    -- grep
    { '<leader>sb', function() FzfLua.grep_curbuf() end, desc = 'Current Buffer Lines' },
    { '<leader>sB', function() FzfLua.lines() end, desc = 'Grep Open Buffers' },
    { '<leader>sg', function() FzfLua.live_grep() end, desc = 'Grep' },
    { '<leader>sG', function() FzfLua.live_grep({ cwd = vim.uv.cwd() }) end, desc = 'Grep (cwd)' },
    { '<leader>sw', function() FzfLua.grep_cword() end, desc = 'Grep cword' },
    { '<leader>sW', function() FzfLua.grep_cword({ cwd = vim.uv.cwd() }) end, desc = 'Grep cword (cwd)' },
    { '<leader>sw', function() FzfLua.grep_visual() end, desc = 'Grep selection', mode = 'x' },
    {
      '<leader>sW',
      function() FzfLua.grep_visual({ cwd = vim.uv.cwd() }) end,
      desc = 'Grep selection (cwd)',
      mode = 'x',
    },
    -- search
    { '<leader>s"', function() FzfLua.registers() end, desc = 'Registers' },
    { '<leader>s/', function() FzfLua.search_history() end, desc = 'Search History' },
    { '<leader>sa', function() FzfLua.autocmds() end, desc = 'Autocmds' },
    { '<leader>sc', function() FzfLua.command_history() end, desc = 'Command History' },
    { '<leader>sC', function() FzfLua.commands() end, desc = 'Commands' },
    { '<leader>sh', function() FzfLua.help_tags() end, desc = 'Help Pages' },
    { '<leader>sH', function() FzfLua.highlights() end, desc = 'Highlights' },
    { '<leader>sj', function() FzfLua.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() FzfLua.keymaps() end, desc = 'Keymaps' },
    { '<leader>sl', function() FzfLua.loclist() end, desc = 'Location List' },
    { '<leader>sm', function() FzfLua.marks() end, desc = 'Marks' },
    { '<leader>sM', function() FzfLua.manpages() end, desc = 'Man Pages' },
    { '<leader>sq', function() FzfLua.quickfix() end, desc = 'Quickfix List' },
    { '<leader>sR', function() FzfLua.resume() end, desc = 'Resume' },
    { '<leader>st', '<cmd>TodoFzfLua<CR>', desc = 'Todo' },
    { '<leader>uC', function() FzfLua.colorschemes() end, desc = 'Colorschemes' },
    -- LSP / Diagnostics
    { 'gd', function() FzfLua.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gD', function() FzfLua.lsp_declarations() end, desc = 'Goto Declaration' },
    { 'grr', function() FzfLua.lsp_references() end, nowait = true, desc = 'References' },
    { 'gri', function() FzfLua.lsp_implementations() end, desc = 'Goto Implementation' },
    -- Note: the silent=true below is to suppress warning about vim.ui.select
    { 'gra', function() FzfLua.lsp_code_actions({ silent = true }) end, desc = 'Code Actions' },
    { 'grt', function() FzfLua.lsp_typedefs() end, desc = 'Goto Type Definition' },
    { 'gy', function() FzfLua.lsp_typedefs() end, desc = 'Goto Type Definition' },
    { 'gi', function() FzfLua.lsp_incoming_calls() end, desc = 'Incoming calls' },
    { 'go', function() FzfLua.lsp_outgoing_calls() end, desc = 'Outgoing calls' },
    { '<leader>ss', function() FzfLua.lsp_document_symbols() end, desc = 'LSP Symbols' },
    { '<leader>sS', function() FzfLua.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
    { '<leader>sd', function() FzfLua.diagnostics_document() end, desc = 'Diagnostics' },
    { '<leader>sD', function() FzfLua.diagnostics_workspace() end, desc = 'Buffer Diagnostics' },
  },
}
