return {
  'echasnovski/mini.files',
  enabled = false,
  opts = {
    windows = {
      preview = true,
      width_preview = 50,
    },
    options = {
      use_as_default_explorer = false,
    },
  },
  config = function(_, opts)
    require('mini.files').setup(opts)

    vim.keymap.set('n', '<leader>fm', function()
      require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
    end, { desc = 'Open mini.files (directory of current file)' })
    vim.keymap.set('n', '<leader>fM', function()
      require('mini.files').open(vim.loop.cwd(), true)
    end, { desc = 'Open mini.files (cwd)' })

    local show_dotfiles = true
    local filter_show = function()
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require('mini.files').refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        require('lazyvim.util').lsp.on_rename(event.data.from, event.data.to)
      end,
    })
  end,
}
