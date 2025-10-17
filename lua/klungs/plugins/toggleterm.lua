---@module "toggleterm"
---@module "lazy"

---@type LazySpec
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  ---@type ToggleTermConfig
  opts = {
    open_mapping = '<c-/>',
    size = 20,
  },
}
