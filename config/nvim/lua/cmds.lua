local t = require('utils')

local result = vim.api.nvim_exec(
[[
augroup generalgroup
  autocmd!
  " for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,sass,scss,cucumber setlocal ai sw=2 sts=2 et

  " make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python setlocal sw=4 sts=4 et
  autocmd FileType kotlin setlocal sw=4 sts=4 et
  autocmd FileType go setlocal sw=2 noexpandtab

  " autocmd BufWritePost ~/.config/nvim/init.lua nested lua require('utils').reloadConfig()
  " autocmd BufWritePost ~/.config/nvim/vimscript/plugins/*.vim nested lua require('utils').reloadConfig()
  " autocmd BufWritePost ~/.config/nvim/lua/plugins/*.lua nested lua require('utils').reloadConfig()
  " autocmd BufWritePost ~/.config/nvim/lua/*.lua nested lua require('utils').reloadConfig()
augroup END
]],
true)

vimp.map_command('GradleRunTest', function()
  vim.cmd('sp | resize 10 | enew | call termopen("./gradlew test -i --tests ' .. vim.fn.expand('%:t:r') .. '")')
end)
