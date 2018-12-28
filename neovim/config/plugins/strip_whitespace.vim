""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Strips Whitespace on save and maps <leader><space>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Clears trailing whitespace
map <Leader><Space> :call <SID>StripTrailingWhitespaces()<CR>

augroup stripwhitespacegroup
  autocmd!
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END
