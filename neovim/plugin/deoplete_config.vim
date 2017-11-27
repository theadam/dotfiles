if has('nvim')
  let g:deoplete#enable_at_startup=1
  let g:neocomplete#enable_smart_case = 1
  let g:deoplete#enable_auto_select=0
  let g:deoplete#enable_refresh_always=0

  let g:deoplete#file#enable_buffer_path=1

  let javascript_source = ['buffer', 'file', 'ultisnips', 'flow']
  let purescript_source = ['omni', 'buffer', 'file']

  let g:deoplete#sources = {}
  let g:deoplete#sources._    = ['buffer', 'file', 'ultisnips']
  let g:deoplete#sources.javascript = javascript_source
  let g:deoplete#sources.jsx = javascript_source
  let g:deoplete#sources['javascript.jsx'] = javascript_source
  let g:deoplete#sources.purescript = purescript_source

  let g:deoplete#omni_patterns = {}
  let g:deoplete#omni_patterns.reason = '[^. *\t]\.\w*\|\h\w*|#'
  let g:deoplete#sources = {}
  let g:deoplete#sources.reason = ['omni', 'buffer']

  let g:deoplete#omni#input_patterns = {}
  let g:deoplete#omni#input_patterns.purescript = '\w+'
  let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'

  let g:deoplete#omni#functions = {}
  let g:deoplete#omni#functions.purescript = [
    \ 'PSCIDEomni'
  \]

  " For snippet_complete marker.
  " if has('conceal')
  "   set conceallevel=2 concealcursor=i
  " endif
  "
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

  let g:autocomplete_flow#insert_paren_after_function = 0
endif
