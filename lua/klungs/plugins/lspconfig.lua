return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Dependencies to add capabilities into the lsp
    -- 'saghen/blink.cmp'
    -- 'hrsh7th/nvim-cmp',

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- We create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map(
          'grA',
          function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { 'source.fixAll' } },
            })
          end,
          'Code Action Fix All'
        )

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map(
            '<leader>Th',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
            '[T]oggle Inlay [H]ints'
          )
        end
      end,
    })

    -- Setup mason
    require('mason').setup()
    -- local cmp_lsp = require('cmp_nvim_lsp')
    -- local capabilities =
    --   vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

    require('mason-lspconfig').setup({
      automatic_enable = true,
      ensure_installed = {
        'clangd',
        'gopls',
        'rust_analyzer',
        'vtsls',
        'eslint',
        'lua_ls',
        'svelte',
        'postgres_lsp',
      },
    })

    -- Install formarters & linters
    require('mason-tool-installer').setup({
      ensure_installed = {
        'stylua', -- Used to format lua code
        -- 'clang-format',
        'prettierd',
        'prettier',
        'eslint-lsp',
        'tailwindcss',
        'goimports',
      },
    })

    -- Setup code action to fix all fixable errors. Mainly for eslint.
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   callback = function()
    --     vim.lsp.buf.code_action({
    --       apply = true,
    --       context = { only = { 'source.fixAll' } },
    --     })
    --   end,
    -- })
  end,
}
