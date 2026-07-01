return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>uf',
      function()
        if vim.b.disable_autoformat then
          vim.b.disable_autoformat = false
        else
          vim.b.disable_autoformat = true
        end
      end,
      mode = '',
      desc = 'Toggle Auto Format',
    },
  },
  config = function()
    require('conform').setup({
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Check if auto-format is disabled for the current buffer
        if vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable if it's QMK specific keymap.c file, to avoid format conflict with qmk.nvim plugin
        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        if buf_name:match('keymap.c$') then
          return
        end

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes =
          { c = true, cpp = true, javascript = true, typescript = true, typescriptreact = true, javascriptreact = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'oxfmt' },
        typescript = { 'oxfmt' },
        typescriptreact = { 'oxfmt' },
        javascriptreact = { 'oxfmt' },
        json = { 'oxfmt' },
        rust = { 'rustfmt' },
        go = { 'goimports', 'gofumpt' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        jai = function(bufnr)
          -- Don't enable formatter if it's inside the compiler/stdlib path.
          local jai_path = vim.env.JAI_PATH or vim.fn.expand('~/jai/jai')
          local filename = vim.api.nvim_buf_get_name(bufnr)
          if vim.startswith(filename, jai_path) then
            return {}
          end
          return { 'jai-format' }
        end,
      },
      formatters = {
        clang_format = {
          prepend_args = { '--style=file', '--fallback-style=LLVM' },
        },
        ['jai-format'] = {
          command = 'jai-format',
          args = { '-silent', '-to_file', '$FILENAME' },
          cwd = require('conform.util').root_file({ '.jai-format' }),
          stdin = false,
        },
      },
    })
  end,
}
