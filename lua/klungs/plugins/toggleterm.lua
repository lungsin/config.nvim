---@module "toggleterm"
---@module "lazy"

---@type LazySpec
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  enabled = false,
  opts = {
    open_mapping = '<c-/>',
    size = function(term)
      if term.direction == 'horizontal' then
        return 20
      elseif term.direction == 'vertical' then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
  },
}
