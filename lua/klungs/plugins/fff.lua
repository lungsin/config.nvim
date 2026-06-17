return {
  'dmtrKovalenko/fff.nvim',
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require('fff.download').download_or_build_binary()
  end,
  -- for nixos:
  -- build = "nix run .#release",
  opts = {
    debug = {
      -- enabled = true,
      show_scores = true,
    },
    layout = {
      prompt_position = 'top',
    },
  },
  lazy = false, -- the plugin lazy-initialises itself
  keys = {
    { '<leader>/', function() require('fff').live_grep() end, desc = 'Grep (FFF)' },
    { '<leader>f.', function() require('fff').resume() end, desc = 'Resume (FFF)' },
    { '<leader>ff', function() require('fff').find_files() end, desc = 'Find Files (FFF)' },
    {
      '<leader>fc',
      function() require('fff').find_files_in_dir(vim.fn.stdpath('config')) end,
      desc = 'Find Config File (FFF)',
    },
    {
      '<leader>fo',
      function()
        require('fff').find_files({
          title = 'Oil',
          prompt = 'Oil❯ ',
          on_submit = function(_, ctx)
            local file_path = ctx.path
            if not file_path or file_path == '' then
              return
            end
            local dir_path = file_path:match('^(.*)[/\\][^/\\]*$')
            require('oil').toggle_float(dir_path)
          end,
        })
      end,
      desc = 'Find Directory in Oil (FFF)',
    },
    { '<leader>sg', function() require('fff').live_grep() end, desc = 'Grep (FFF)' },
    {
      '<leader>sz',
      function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end,
      desc = 'Grep Fuzzy (FFF)',
    },
    {
      '<leader>sw',
      function() require('fff').live_grep({ query = vim.fn.expand('<cword>') }) end,
      desc = 'Grep Word (FFF)',
    },
    {
      '<leader>sW',
      function() require('fff').live_grep({ query = vim.fn.expand('<cWORD>') }) end,
      desc = 'Grep WORD (FFF)',
    },
  },
}
