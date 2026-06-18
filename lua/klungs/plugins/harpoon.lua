return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({
      default = {
        create_list_item = function(config, item)
          item = require('harpoon.config').get_default_config().default.create_list_item(config, item)
          vim.notify('Harpoon: added ' .. item.value)
          return item
        end,
      },
    })
    harpoon:extend(require('harpoon.extensions').builtins.highlight_current_file())

    local harpoon_add = function() harpoon:list():add() end
    local harpoon_list = function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
    vim.keymap.set('n', '<c-b>', harpoon_add, { desc = 'Add to harpoon list' })
    vim.keymap.set('n', '<c-s-b>', harpoon_list, { desc = 'Harpoon list' })
    vim.keymap.set('n', '<leader>ba', harpoon_add, { desc = 'Add to harpoon list' })
    vim.keymap.set('n', '<leader>bb', harpoon_list, { desc = 'Harpoon list' })

    -- Using <leader>1..5 so switch file
    for _, idx in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }) do
      vim.keymap.set('n', string.format('<c-%d>', idx), function() harpoon:list():select(idx) end)
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<c-left>', function() harpoon:list():prev({ ui_nav_wrap = true }) end)
    vim.keymap.set('n', '<c-right>', function() harpoon:list():next({ ui_nav_wrap = true }) end)
  end,
}
