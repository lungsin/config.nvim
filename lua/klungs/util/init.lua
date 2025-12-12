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

return M
