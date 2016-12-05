let g:neomake_verbose=0
let g:neomake_open_list=2

let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_jsx_enabled_makers = ['eslint_d']

autocmd! BufWritePost * Neomake
