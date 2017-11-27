if !has('nvim')
  let g:completor_reason_omni_trigger = '[^. *\t]\.\w*\|\h\w*|#'
  let g:completor_javascript_omni_trigger = "\\w+$|[\\w\\)\\]\\}\'\"]+\\.\\w*$"
  let g:completor_jsx_omni_trigger = "\\w+$|[\\w\\)\\]\\}\'\"]+\\.\\w*$"
  let g:completor_min_chars = 0
  let g:completor_refresh_always = 0

  "let g:completor_disable_filename = ['reason', 'javascript', 'jsx']
  "let g:completor_disable_buffer = ['reason', 'javascript', 'jsx']

  let g:completor_auto_trigger = 1
  let g:completor_completion_delay = 10
endif
