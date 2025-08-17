-- Fuzzy Finder (files, lsp, etc)
return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  enabled = false,
  dependencies = {
    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local fzf = require('fzf-lua')
    fzf.setup({})

    vim.keymap.set(
      'n',
      '<leader>,',
      '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
      { desc = 'Switch Buffer' }
    )
    vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Grep (Root Dir)' })
    vim.keymap.set('n', '<leader>:', '<cmd>FzfLua command_history<cr>', { desc = 'Command History' })
    vim.keymap.set('n', '<leader><space>', '<cmd>FzfLua files<cr>', { desc = 'Find Files (Root Dir)' })
    -- find
    vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Buffers' })
    vim.keymap.set(
      'n',
      '<leader>fc',
      function() fzf.files({ cwd = vim.fn.stdpath('config') }) end,
      { desc = 'Find Config File' }
    )
    vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find Files (Root Dir)' })
    vim.keymap.set('n', '<leader>fF', function() fzf.files({ cwd = vim.uv.cwd() }) end, { desc = 'Find Files (cwd)' })
    vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua git_files<cr>', { desc = 'Find Files (git-files)' })
    vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Recent' })
    vim.keymap.set('n', '<leader>fR', function() fzf.oldfiles({ cwd = vim.uv.cwd() }) end, { desc = 'Recent (cwd)' })
    -- git
    vim.keymap.set('n', '<leader>gc', '<cmd>FzfLua git_commits<CR>', { desc = 'Commits' })
    vim.keymap.set('n', '<leader>gs', '<cmd>FzfLua git_status<CR>', { desc = 'Status' })
    -- search
    vim.keymap.set('n', '<leader>s"', '<cmd>FzfLua registers<cr>', { desc = 'Registers' })
    vim.keymap.set('n', '<leader>sa', '<cmd>FzfLua autocmds<cr>', { desc = 'Auto Commands' })
    vim.keymap.set('n', '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', { desc = 'Buffer' })
    vim.keymap.set('n', '<leader>sc', '<cmd>FzfLua command_history<cr>', { desc = 'Command History' })
    vim.keymap.set('n', '<leader>sC', '<cmd>FzfLua commands<cr>', { desc = 'Commands' })
    vim.keymap.set('n', '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', { desc = 'Document Diagnostics' })
    vim.keymap.set('n', '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', { desc = 'Workspace Diagnostics' })
    vim.keymap.set('n', '<leader>sg', '<cmd>FzfLua live_grep<cr>', { desc = 'Grep (Root Dir)' })
    vim.keymap.set('n', '<leader>sG', function() fzf.live_grep({ cwd = vim.uv.cwd() }) end, { desc = 'Grep (cwd)' })
    vim.keymap.set('n', '<leader>sh', '<cmd>FzfLua help_tags<cr>', { desc = 'Help Pages' })
    vim.keymap.set('n', '<leader>sH', '<cmd>FzfLua highlights<cr>', { desc = 'Search Highlight Groups' })
    vim.keymap.set('n', '<leader>sj', '<cmd>FzfLua jumps<cr>', { desc = 'Jumplist' })
    vim.keymap.set('n', '<leader>sk', '<cmd>FzfLua keymaps<cr>', { desc = 'Key Maps' })
    vim.keymap.set('n', '<leader>sl', '<cmd>FzfLua loclist<cr>', { desc = 'Location List' })
    vim.keymap.set('n', '<leader>sM', '<cmd>FzfLua man_pages<cr>', { desc = 'Man Pages' })
    vim.keymap.set('n', '<leader>sm', '<cmd>FzfLua marks<cr>', { desc = 'Jump to Mark' })
    vim.keymap.set('n', '<leader>sR', '<cmd>FzfLua resume<cr>', { desc = 'Resume' })
    vim.keymap.set('n', '<leader>sq', '<cmd>FzfLua quickfix<cr>', { desc = 'Quickfix List' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = 'Word (Root Dir)' })
    vim.keymap.set('n', '<leader>sW', function() fzf.grep_cword({ cwd = vim.uv.cwd() }) end, { desc = 'Word (cwd)' })
    vim.keymap.set('v', '<leader>sw', fzf.grep_visual, { desc = 'Selection (Root Dir)' })
    vim.keymap.set(
      'v',
      '<leader>sW',
      function() fzf.grep_visual({ cwd = vim.uv.cwd() }) end,
      { desc = 'Selection (cwd)' }
    )
    vim.keymap.set('n', '<leader>sC', fzf.colorschemes, { desc = 'Colorscheme with Preview' })
    vim.keymap.set('n', '<leader>ss', fzf.lsp_document_symbols, { desc = 'Goto Symbol' })
    vim.keymap.set('n', '<leader>sS', fzf.lsp_live_workspace_symbols, { desc = 'Goto Symbol (Workspace)' })

    -- Lsp related operation
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('fzf-lsp-attach', { clear = true }),
      callback = function(event)
        -- We create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', '<cmd>FzfLua lsp_definitions jump1=true<cr>', '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', '<cmd>FzfLua lsp_references jump1=true<cr>', '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', '<cmd>FzfLua lsp_implementations jump1=true<cr>', '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>gy', '<cmd>FzfLua lsp_typedefs jump1=true<cr>', 'T[y]pe Definition')
      end,
    })
  end,
}
