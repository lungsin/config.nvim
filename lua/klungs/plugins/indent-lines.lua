return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = { char = '│' },
    },
  },
}
