let g:deoplete#enable_at_startup=1
let g:neocomplete#enable_smart_case = 1
let g:deoplete#enable_auto_select=0
let g:deoplete#enable_refresh_always=0

let g:deoplete#file#enable_buffer_path=1

let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom-snippets"]

let javascript_source = ['buffer', 'file', 'ultisnips', 'flow']

let g:deoplete#sources = {}
let g:deoplete#sources._    = ['buffer', 'file', 'ultisnips']
let g:deoplete#sources.javascript = javascript_source
let g:deoplete#sources.jsx = javascript_source
let g:deoplete#sources['javascript.jsx'] = javascript_source

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" For snippet_complete marker.
" if has('conceal')
"   set conceallevel=2 concealcursor=i
" endif
