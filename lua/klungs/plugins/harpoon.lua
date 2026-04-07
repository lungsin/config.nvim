return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()

    local harpoon_add = function() harpoon:list():add() end
    local harpoon_list = function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
    vim.keymap.set('n', '<c-h>', harpoon_add, { desc = 'Add to harpoon list' })
    vim.keymap.set('n', '<leader>b<c-h>', harpoon_add, { desc = 'Add to harpoon list' })
    vim.keymap.set('n', '<leader>bh', harpoon_list, { desc = 'Harpoon list' })

    -- Using <leader>1..5 so switch file
    for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
      vim.keymap.set('n', string.format('<c-%d>', idx), function() harpoon:list():select(idx) end)
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<c-left>', function() harpoon:list():prev() end)
    vim.keymap.set('n', '<c-right>', function() harpoon:list():next() end)
  end,
}
