autocmd FileType reason nmap <buffer> <leader>t :MerlinTypeOf<Cr>
autocmd FileType reason nmap <buffer> gf :MerlinLocate<Cr>
autocmd FileType reason nmap <buffer> <leader>n :MerlinGrowEnclosing<Cr>
autocmd FileType reason nmap <buffer> <leader>p :MerlinShrinkEnclosing<Cr>
autocmd FileType reason nmap <buffer> <leader>r :!runreason %<Cr>
autocmd FileType reason nmap <buffer> <leader>v :ReasonPrettyPrint<Cr>

autocmd! BufWritePre,BufReadPost *.re ReasonPrettyPrint
