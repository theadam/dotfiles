local M = {}

local vimrc = '~/.config/nvim/init.lua'

local unloadAll = function()
  for k, v in pairs(package.loaded) do
    package.loaded[k] = nil
  end
end

local loadInit = function()
  vim.cmd('source ' .. vimrc)
end

M.reloadConfig = function()
  vimp.unmap_all()
  unloadAll()
  loadInit()
  print('Reloaded ' .. vimrc)
  vim.cmd 'redraw'
end

return M

