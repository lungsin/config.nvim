-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  -- branch = '0.1.x',
  -- enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    -- Browse the current buffer's undo tree in a text-based tree representation using telescope.
    'debugloop/telescope-undo.nvim',
  },
  -- init = function()
  --   -- Autocommand to open telescope when entering nvim
  --   -- TODO: Organize this autocommand using the lazy.nvim config or in after/plugin folder.
  --   --
  --   -- clear FileExplorer appropriately to prevent netrw from launching on folders
  --   -- netrw may or may not be loaded before telescope-find-files
  --   -- conceptual credits to nvim-tree and telescope-file-browser
  --   vim.api.nvim_create_autocmd('VimEnter', {
  --     pattern = '*',
  --     once = true,
  --     callback = function()
  --       pcall(vim.api.nvim_clear_autocmds, { group = 'FileExplorer' })
  --     end,
  --   })

  --   local find_files_hijack_netrw = vim.api.nvim_create_augroup('find_files_hijack_netrw', { clear = true })
  --   vim.api.nvim_create_autocmd('BufEnter', {
  --     group = find_files_hijack_netrw,
  --     pattern = '*',
  --     callback = function()
  --       vim.schedule(function()
  --         -- Early return if netrw or not a directory
  --         if vim.bo[0].filetype == 'netrw' or vim.fn.isdirectory(vim.fn.expand('%:p')) == 0 then
  --           return
  --         end

  --         vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')

  --         require('telescope.builtin').find_files({
  --           cwd = vim.fn.expand('%:p:h'),
  --         })
  --       end)
  --     end,
  --   })
  -- end,
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        undo = {
          side_by_side = true,
          layout_strategy = 'vertical',
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
      defaults = {
        path_display = { 'filename_first' },
        mappings = {
          i = {
            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
          },
        },
        file_ignore_patterns = { 'node_modules', '.git/' },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'undo')

    -- See `:help telescope.builtin`
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'Find Telescope builtin' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under the cursor' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find and get Live Results' })
    vim.keymap.set('n', '<leader>fG', builtin.git_files, { desc = 'Find git files' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume last search session' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Telescope undo extension
    vim.keymap.set('n', '<leader>fu', '<cmd>Telescope undo<cr>', { desc = 'Find Undo tree' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end, { desc = 'Find [/] in Open Files' })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = 'Find Neovim files' })
  end,
}
