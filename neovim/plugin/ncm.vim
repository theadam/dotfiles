imap <expr> <CR> (pumvisible() ? "\<C-Y>\<CR>\<Plug>DiscretionaryEnd" : "\<CR>\<Plug>DiscretionaryEnd")

let g:cm_sources_override = {
    \ 'flow': {
      \ 'scopes': ['javascript', 'javascript.jsx']}
    \ }

