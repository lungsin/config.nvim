---@module "snacks"
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = false },
    indent = { enabled = true },
    picker = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = false },
  },
}
