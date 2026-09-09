-- Jinja files are almost always a template on top of another format
-- (`app.toml.j2`, `.env.j2`, `nginx.conf.j2`, ...).
--
-- Treesitter takes care of the jinja tags themselves (the `jinja` parser only
-- produces nodes for `{{ }}`/`{% %}` and leaves the rest as plain `content`),
-- and vim's regex syntax highlights the underlying format underneath it.
-- Both can be active at once: treesitter marks have a higher priority than
-- syntax ones, so the jinja tags always win. See `:h vim.hl.priorities`.
vim.bo.commentstring = '{# %s #}'

local buf = vim.api.nvim_get_current_buf()
local name = vim.api.nvim_buf_get_name(buf)

-- Everything is deferred: `vim.treesitter.start()` turns 'syntax' off and runs
-- from a FileType autocmd, i.e. after this ftplugin, and the content based
-- filetype rules (`*.sh`, ...) bail out while `did_filetype()` is still set.
vim.schedule(function()
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  -- `app.toml.j2` -> `app.toml` -> `toml`. Names that carry no filetype on
  -- their own (`site.conf`, `deploy.j2`, ...) stay plain jinja, use
  -- `:setl syntax=conf` to set the underlying format by hand.
  local base_ft = vim.filetype.match({ filename = (name:gsub('%.[^.]+$', '')), buf = buf })
  if base_ft and base_ft ~= 'jinja' then
    vim.bo[buf].syntax = base_ft
  end
end)
