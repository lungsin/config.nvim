---@module "snacks"
---@module "lazy"

local function is_fish_shell() return vim.o.shell:match('fish') ~= nil end

-- The following is the `nvim-remote` preset from lazygit config, with `--remote-tab` replaced with `--remote`
local function get_lazygit_os_config()
  if is_fish_shell() then
    return {
      edit = 'begin; if test -z "$NVIM"; nvim -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{filename}}; end; end',
      editAtLine = 'begin; if test -z "$NVIM"; nvim +{{line}} -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{filename}}; nvim --server "$NVIM" --remote-send ":{{line}}<CR>"; end; end',
      editAtLineAndWait = 'nvim +{{line}} {{filename}}',
      openDirInEditor = 'begin; if test -z "$NVIM"; nvim -- {{dir}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{dir}}; end; end',
    }
  end
  return {
    edit = '[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})',
    editAtLine = '[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" &&  nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")',
    editAtLineAndWait = 'nvim +{{line}} {{filename}}',
    openDirInEditor = '[ -z "$NVIM" ] && (nvim -- {{dir}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{dir}})',
  }
end

---@type snacks.win?
local lazygit_win = nil

---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = false },
    indent = {
      enabled = true,
      animate = { enabled = false },
      scope = { only_current = true },
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      -- Enabled to override vim.ui.select
      enabled = true,
      matcher = { frecency = true },
    },
    explorer = {
      enabled = true,
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true }, -- Wrap notifications
      },
      notification_history = {
        keys = {
          ['<ESC>'] = 'close',
          ['<C-c>'] = 'close',
        },
      },
    },
    lazygit = {
      enabled = true,
      config = {
        os = get_lazygit_os_config(),
      },
    },
  },
  keys = {
    -- File explorer
    { '<leader>fe', function() Snacks.explorer() end, desc = 'File Explorer' },
    -- Git
    { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
    { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
    { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
    { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
    { '<leader>gx', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
    { '<leader>gq', function() Snacks.git.blame_line() end, desc = 'Git blame line', mode = { 'n', 'v' } },
    { '<c-g>', function() Snacks.lazygit() end, desc = 'Lazygit', mode = { 'n', 't' } },
    -- Other
    { '<leader>unh', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    { '<leader>und', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    --
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer with preserved layout' },
    --
    -- { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal', mode = { 'n', 't' } },
    -- { '<c-_>', function() Snacks.terminal() end, desc = 'which_key_ignore', mode = { 'n', 't' } },
  },
}
