return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = true,
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_format = 'fallback',
    -- },
    format_after_save = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      rust = { 'rustfmt' },
      go = { 'goimports' },
    },
  },
}
