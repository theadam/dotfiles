augroup generalgroup
  autocmd!
  " for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,sass,scss,cucumber setlocal ai sw=2 sts=2 et

  " make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python setlocal sw=4 sts=4 et

  autocmd BufWritePost $MYVIMRC nested source % | echom "Reloaded " . $MYVIMRC | redraw
  autocmd BufWritePost ~/.config/nvim/config/*.vim nested source $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
augroup END
