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
        'caddy',
        'diff',
        'go',
        'gomod',
        'gosum',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'make',
        'python',
        'tsx',
        'javascript',
        'typescript',
        'svelte',
        'sql',
        'vim',
        'vimdoc',
        'yaml',
      }

      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- Check if a parser exists and load it
        if not vim.treesitter.language.add(language) then
          return
        end
        -- Enable syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- Enable treesitter based folds
        -- For more info on folds see `:help folds`
        local has_fold_query = vim.treesitter.query.get(language, 'folds') ~= nil
        if has_fold_query then
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldmethod = 'expr'
        end

        -- Check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

        -- Enable treesitter based indentation
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      -- Enable highlight, fold, and indent for all filetype
      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require('nvim-treesitter').get_installed('parsers')

          if vim.tbl_contains(installed_parsers, language) then
            -- Enable the parser if it is already installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
            require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
          else
            -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
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
              revision = '2763e5001856ea7b5047e780e8dec95a07072d59',
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
      { '<leader>uc', '<cmd>TSContext toggle<CR>', desc = 'Toggle Treesitter Context' },
    },
  },
}
