local opencode_cmd = 'opencode'
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = 'right',
    enter = false,
  },
}

--- Open (or get) the opencode terminal, optionally hiding the window.
--- The terminal/job is created on first call; on subsequent calls the
--- existing instance is returned.
---@param opts { show: boolean? }? Show the terminal; newly created terminals default to hidden.
local function open_opencode_terminal(opts)
  opts = opts or { show = false }
  local win, created = require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts)
  if win then
    if opts.show then
      win:show()
    elseif created then
      win:hide()
    end
  end
  return win
end

--- Send keys directly to the OpenCode TUI.
--- OpenCode V2 removed the TUI control API previously used by `opencode.command()`.
---@param keys string
local function send_opencode_keys(keys)
  local win = open_opencode_terminal({ show = false })
  if not win then
    return
  end

  local channel = vim.api.nvim_get_option_value('channel', { buf = win.buf })
  if channel == 0 then
    vim.notify('OpenCode terminal is not running', vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_chan_send(channel, keys)
end

-- OpenCode V2 default CLI keybindings. Alt is encoded as an escape prefix.
local opencode_keys = {
  session_new = string.char(24) .. 'n', -- <C-x>n
  session_half_page_up = string.char(27, 21), -- <C-M-u>
  session_half_page_down = string.char(27, 4), -- <C-M-d>
  prompt_clear = string.char(3), -- <C-c>
  prompt_submit = string.char(13), -- <CR>
}

return {
  'NickvanDyke/opencode.nvim',
  -- dir = '~/git/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim', -- Requires input, picker, terminal modules (configured in snacks.lua)
  },
  enabled = true,
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function() open_opencode_terminal({ show = true }) end,
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    local keymap_set = require('klungs.utils').keymap_set

    -- Pre-start the OpenCode TUI on startup
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('klungs_opencode_prewarm', { clear = true }),
      callback = function()
        -- Defer so it doesn't slow down UI paint on startup.
        vim.defer_fn(function() open_opencode_terminal({ show = false }) end, 100)
      end,
    })

    -- Ask
    keymap_set({ 'n', 'x' }, '<c-a>', function()
      send_opencode_keys(opencode_keys.session_new)
      require('opencode').ask('@this: ')
    end, { desc = 'Ask opencode in new session' })

    keymap_set(
      { 'n', 'x' },
      '<c-s-a>',
      function() require('opencode').ask() end,
      { desc = 'Ask opencode in the latest session' }
    )

    -- Select actions
    keymap_set(
      { 'n', 'x' },
      { '<c-x>', '<leader>ax' },
      function() require('opencode').select() end,
      { desc = 'Execute opencode action…' }
    )
    keymap_set(
      { 'n', 't' },
      '<C-.>',
      function() require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts) end,
      { desc = 'Toggle opencode' }
    )

    -- Operator to send ranges
    keymap_set(
      { 'n', 'x' },
      'go',
      function() return require('opencode').operator('@this') end,
      { desc = 'Send range to OpenCode', expr = true }
    )
    keymap_set(
      'n',
      'goo',
      function() return require('opencode').operator('@this') .. '_' end,
      { desc = 'Send line to OpenCode', expr = true }
    )

    -- Navigation
    keymap_set(
      'n',
      '<S-C-u>',
      function() send_opencode_keys(opencode_keys.session_half_page_up) end,
      { desc = 'opencode half page up' }
    )

    keymap_set(
      'n',
      '<S-C-d>',
      function() send_opencode_keys(opencode_keys.session_half_page_down) end,
      { desc = 'opencode half page down' }
    )

    -- Clear / Submit prompt
    keymap_set(
      'n',
      '<leader>ac',
      function() send_opencode_keys(opencode_keys.prompt_clear) end,
      { desc = 'opencode clear prompt' }
    )

    keymap_set(
      'n',
      { '<leader>a<enter>', '<leader>as' },
      function() send_opencode_keys(opencode_keys.prompt_submit) end,
      { desc = 'opencode submit prompt' }
    )

    -- Remap increment/decrement if using <C-a> and <C-x> for opencode
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  end,
}
