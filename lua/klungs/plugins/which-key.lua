---@module "which-key"
---@module "lazy"

-- Useful plugin to show you pending keybinds.
---@type "LazySpec"
return {
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  ---@type wk.Opts
  opts = {
    preset = 'helix',
    spec = {
      { '<leader>a', group = 'AI' },
      { '<leader>b', group = 'Bookmark (Harpoon)' },
      { '<leader>f', group = 'File/Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
      -- { '<leader>n', group = 'Navigation' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Test' },
      -- { '<leader>T', group = 'Toggle' },
      { '<leader>u', group = 'Editor/UI/Notification', icon = { icon = '󰙵 ', color = 'cyan' } },
      { '<leader>un', group = 'Notification', icon = { icon = '󰙵 ', color = 'cyan' } },
      { '<leader>q', group = 'Session' },
      { '[', group = 'prev' },
      { ']', group = 'next' },
      { 'g', group = 'goto' },
      { 'gr', group = 'lsp' },
      { 'z', group = 'fold' },
      -- better descriptions
      { 'gx', desc = 'Open with system app' },
      { 'grx', desc = 'Codelens' },
    },
  },
  keys = {
    {
      '<leader>?',
      function() require('which-key').show({ global = false }) end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
    {
      '<c-w><space>',
      function() require('which-key').show({ keys = '<c-w>', loop = true }) end,
      desc = 'Window Hydra Mode (which-key)',
    },
  },
}
