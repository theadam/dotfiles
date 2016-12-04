let g:neomake_verbose=0
let g:neomake_open_list=2

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake
