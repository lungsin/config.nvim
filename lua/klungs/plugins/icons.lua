return {
  'nvim-tree/nvim-web-devicons',
  enabled = false,
  opts = {
    strict = true,
    override_by_extension = {
      ['jai'] = {
        icon = 'J',
        name = 'Log',
      },
    },
  },
}
