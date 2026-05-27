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
      { '<leader>Q', group = 'Session' },
      { 'g', group = 'goto' },
      { 'gr', group = 'lsp' },
      { 'z', group = 'fold' },
      -- better descriptions
      { 'gx', desc = 'Open with system app' },
      { 'grx', desc = 'Codelens' },
      { '<leader>d', hidden = true },
      -- Better description for square brackets motion
      { '[', group = 'Prev' },
      { ']', group = 'Next' },
      { '[b', desc = 'Prev buffer' },
      { ']b', desc = 'Next buffer' },
      { '[d', desc = 'Prev diagnostic' },
      { ']d', desc = 'Next diagnostic' },
      { '[l', desc = 'Prev location list entry' },
      { ']l', desc = 'Next location list entry' },
      { '[i', desc = 'Prev indent' },
      { ']i', desc = 'Next indent' },
      { '[m', desc = 'Prev method/function start' },
      { ']m', desc = 'Next method/function start' },
      { '[M', desc = 'Prev method/function end' },
      { ']M', desc = 'Next method/function end' },
      { '[q', desc = 'Prev quickfix entry' },
      { ']q', desc = 'Next quickfix entry' },
      { '[s', desc = 'Prev misspelled word' },
      { ']s', desc = 'Next misspelled word' },
      { '[t', desc = 'Prev tag stack' },
      { ']t', desc = 'Next tag stack' },
      { '[[', desc = 'Prev section/class start' },
      { ']]', desc = 'Next section/class start' },
      { '[]', desc = 'Prev section/class end' },
      { '][', desc = 'Next section/class end' },
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
  init = function() end,
}
