return {
  -- Using default keymaps
  {
    '19bischof/nvim-ansible-vault',
    -- Pinned: upstream f2516a8 ("cleanup augroup") deleted the `original_win`
    -- local from Popup.open but left its two uses in close_popup(), so every
    -- save/close path throws "Invalid 'win': Expected Lua number". Unpin once
    -- that is fixed upstream.
    commit = '979194300592964a1097851e275ac6c703504c47',
  },

  -- Keymaps are configured in ftplugin/ansible.lua as recommended by the plugin README
  { 'mfussenegger/nvim-ansible' },
}
