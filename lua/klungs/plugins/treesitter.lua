-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'nvim-treesitter/nvim-treesitter-context', opts = { multiline_threshold = 1 } },
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'go',
      'html',
      'lua',
      'python',
      'rust',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'markdown',
      'zig',
    },

    -- Autoinstall languages that are not installed
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },

    textobjects = {
      enable = false,
      select = {
        enable = false,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    -- NOTE: Jai is currently not supported by nvim-treesitter. This chunk of code
    -- is a workaround to get syntax highlighting working for Jai files.
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.jai = {
      install_info = {
        url = 'https://github.com/constantitus/tree-sitter-jai.git',
        files = { 'src/parser.c', 'src/scanner.c' },
      },
      filetype = 'jai',
      filetype_to_parsername = 'jai',
      indent = {
        enable = true,
      },
    }
  end,
}
