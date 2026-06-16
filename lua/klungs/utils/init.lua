local M = {}

--- Check if a lazy plugin is loaded
function M.is_loaded(name)
  local Config = require('lazy.core.config')
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

--- Run the function fn when the module fn is loaded
---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

--- Check if the os is ubuntu / debian based
--- @return boolean
function M.is_debian_based()
  local f = io.open('/etc/debian_version', 'r')
  if f then
    f:close()
    return true
  else
    return false
  end
end

--- Set keymap(s). Like `vim.keymap.set`, but `lhs` may be a string or an array of strings.
---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.keymap_set(mode, lhs, rhs, opts)
  if type(lhs) == 'table' then
    for _, l in ipairs(lhs) do
      vim.keymap.set(mode, l, rhs, opts)
    end
  else
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
