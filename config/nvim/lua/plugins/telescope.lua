local telescope = require('telescope.builtin')
local theme = require('telescope.themes').get_ivy()
local union = require('pl.tablex').union

local function getDir()
  return vim.fn.fnamemodify(vim.fn.expand('%'), ':p:h')
end

vimp.bind('nvo', '<c-p>', function()
  if (not(pcall(function () telescope.git_files(theme) end))) then
    telescope.find_files(theme)
  end
end)
vimp.bind('nvo', '<leader>p', function()
  local opts = union({search_dirs = {getDir()}}, theme)
  telescope.find_files(opts)
end)
vimp.bind('n', [[\]], function()
  telescope.live_grep(theme)
end)
vimp.bind('n', '<leader>\\', function()
  local opts = union({search_dirs = {getDir()}}, theme)
  telescope.live_grep(opts)
end)

