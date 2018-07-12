set completeopt-=preview

augroup lsp
  au!

  if executable('flow-language-server')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'flow-language-server',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'flow-language-server --stdio']},
          \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
          \ 'whitelist': ['javascript', 'javascript.jsx'],
          \ })
  endif

  if executable('rls')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'rls',
          \ 'cmd': {server_info->['rustup run nightly rls']},
          \ 'whitelist': ['rust'],
          \ })
  endif

  if executable('pipenv')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pipenv run pyls']},
          \ 'whitelist': ['python'],
          \ })
  endif
augroup END
