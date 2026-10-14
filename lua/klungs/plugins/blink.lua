return {
  'saghen/blink.cmp',
  enabled = true,

  -- use a release tag to download pre-built binaries
  version = 'v1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = {
      preset = 'super-tab',
      ['<C-y>'] = { 'select_and_accept', 'fallback' },
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },

    completion = {
      menu = {
        -- disable auto show to force manual completion
        auto_show = true,
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },

    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = function() return vim.fn.getcmdtype() == ':' end,
        },
      },
    },

    appearance = {
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        -- lazydev.nvim integration with blink.cmp
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- experimental signature help support
    -- TODO: consider using lsp signature help, code ref from Maria Solos:
    --    - https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua
    signature = { enabled = true },
  },

  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.default' },
}
