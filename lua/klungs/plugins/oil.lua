return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('oil').setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      columns = { 'icon' },
      keymaps = {
        -- ['<M-h>'] = 'actions.select_split',
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        border = 'rounded',
      },
    })

    -- Open parent directory in floating window
    vim.keymap.set('n', '<space>-', require('oil').toggle_float, { desc = 'Oil toggle' })
  end,
}
