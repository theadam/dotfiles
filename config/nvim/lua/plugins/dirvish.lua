vim.api.nvim_exec([[
command! Explore :Dirvish %:p:h

augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
augroup END
]],
true)
