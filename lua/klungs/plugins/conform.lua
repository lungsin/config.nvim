return { -- Autoformat
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  keys = {
    {
      '<leader>cf',
      function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
      mode = '',
      desc = 'Conform: Code Format',
    },
    {
      '<leader>tf',
      function()
        if vim.b.disable_autoformat then
          vim.b.disable_autoformat = false
        else
          vim.b.disable_autoformat = true
        end
      end,
      mode = '',
      desc = 'Conform: Toggle Auto Format',
    },
  },
  ---@type conform.setupOpts
  opts = {
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
      -- For FE stuff, we use rely on eslint instead. It's being setup on
      -- the lsp side.
      -- NOTE: Somehow the prettier formatter is quite slow and the prettierd
      -- formatter is conflicting with the lsp code action due to it being async

      -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
      -- typescript = { 'prettierd', 'prettier', stop_after_first = true },
      -- typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      -- javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      rust = { 'rustfmt' },
      go = { 'goimports' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
    },
    formatters = {
      clang_format = {
        prepend_args = { '--style=file', '--fallback-style=LLVM' },
      },
    },
  },
}
