vim.cmd 'autocmd!'
local home = vim.env.HOME

vim.g.python_host_prog = home .. '/.pyenv/versions/neovim2/bin/python'
vim.g.python3_host_prog = home .. '/.pyenv/versions/neovim3/bin/python'

require 'settings'
require 'plugins'
require 'keys'
require 'cmds'

require 'plugins.kbs'

local scan = require 'plenary.scandir'

for i, v in ipairs(scan.scan_dir(home .. '/.config/nvim/vimscript/plugins')) do
  vim.cmd('source ' .. v)
end
