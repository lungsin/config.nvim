-- Patterns instead of `extension` (nvim already maps `.jinja`), with a priority
-- so that they win over nvim's own patterns for the templated file itself,
-- e.g. `.env.j2` would otherwise be detected as `env`.
vim.filetype.add({
  pattern = {
    ['.*%.j2'] = { 'jinja', { priority = 10 } },
    ['.*%.jinja2?'] = { 'jinja', { priority = 10 } },
  },
})
