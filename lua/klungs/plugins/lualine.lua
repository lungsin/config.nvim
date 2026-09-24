local function unsaved_buffers()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.bo[buf].buftype ~= 'nofile' and vim.bo[buf].modified then
      count = count + 1
    end
  end
  return count > 0 and ('Unsaved: %d'):format(count) or ''
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-mini/mini.nvim' },
  opts = {
    sections = {
      lualine_c = {
        { 'filename', path = 1 },
        unsaved_buffers,
      },
    },
  },
}
