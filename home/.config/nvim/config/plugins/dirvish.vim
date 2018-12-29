" Replace netrw with Dirvish
let loaded_netrwPlugin = 1
command! Explore :Dirvish %:p:h

augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
augroup END
