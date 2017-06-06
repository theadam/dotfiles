au FileType purescript nmap <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
au FileType purescript nmap <leader>a :PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <leader>i :PSCIDEimportIdentifier<CR>
au FileType purescript nmap <leader>r :PSCIDEload<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
au FileType purescript nmap <leader>c :PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>qd :PSCIDEremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PSCIDEaddImportQualifications<CR>

function! HandleLintPurs(buffer, lines)
    let l:output = []

    let l:results = PSCIDErebuild(1)
    let l:pattern = '^\([^:]\):[^:]*:\(\d\+\):\(\d\+\):\(.*\)\?$'

    for l:result in l:results
        echo l:result
        let l:match = matchlist(l:result, l:pattern)
        let l:type = toupper(l:match[1])

        call add(l:output, {
        \   'lnum': l:match[2],
        \   'col': l:match[3],
        \   'text': l:match[4],
        \   'type': l:type,
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('purescript', {
\   'name': 'purs-ide',
\   'executable': 'echo',
\   'command': 'echo',
\   'callback': 'HandleLintPurs',
\})

let g:ale_linters.purescript = ['purs-ide']
