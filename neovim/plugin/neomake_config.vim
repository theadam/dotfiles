let g:neomake_verbose=0
"let g:neomake_logfile='neomake.log'
let g:neomake_open_list=2

let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_jsx_enabled_makers = ['eslint_d']

autocmd! BufWritePost * Neomake
" autocmd! BufEnter * Neomake

function! CompressWhitespace(entry) abort
    let text = a:entry.text
    let text = substitute(text, "\001", '', 'g')
    let text = substitute(text, '\r\?\n', ' ', 'g')
    let text = substitute(text, '\m\s\{2,}', ' ', 'g')
    let text = substitute(text, '\m^\s\+', '', '')
    let text = substitute(text, '\m\s\+$', '', '')
    let a:entry.text = text
endfunction

let g:neomake_purescript_lintpurs_maker = {
        \ 'exe': 'lint-purs',
        \ 'errorformat': '%f:%l:%c:%m'
        \ }

let g:neomake_purescript_enabled_makers = ['lintpurs']
