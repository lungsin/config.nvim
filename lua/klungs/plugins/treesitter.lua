-- Highlight, edit, and navigate code
return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
      },
      'nvim-treesitter/nvim-treesitter-context',
    },
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      -- Add languages to be installed here that you want installed for treesitter
      local parsers = {
        'bash',
        'fish',
        'c',
        'cpp',
        'go',
        'gomod',
        'gosum',
        'html',
        'lua',
        'make',
        'python',
        'tsx',
        'javascript',
        'typescript',
        'svelte',
        'sql',
        'vimdoc',
        'vim',
        'yaml',
        'markdown',
        'jai', -- This is installed manually
      }

      local installed = require('nvim-treesitter.config').get_installed()
      local install = vim
        .iter(parsers)
        :filter(function(parser) return not vim.tbl_contains(installed, parser) end)
        :totable()
      require('nvim-treesitter').install(install)

      -- Enable highlight, fold, and indent for all filetype
      vim.api.nvim_create_autocmd('FileType', {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          -- Jai is currently not supported by nvim-treesitter. This chunk of code
          -- is a workaround to get syntax highlighting working for Jai files.
          require('nvim-treesitter.parsers').jai = {
            ---@diagnostic disable-next-line: missing-fields
            install_info = {
              url = 'https://github.com/constantitus/tree-sitter-jai.git',
              revision = 'a73dd2be5dfca88e91e1c4c5229c18769ab7dac7',
              branch = 'master',
            },
            tier = 2,
          }
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = true,
      multiline_threshold = 3,
    },
    keys = {
      { '<leader>Tc', '<cmd>TSContext toggle<CR>', desc = 'Toggle Treesitter Context' },
    },
  },
}
