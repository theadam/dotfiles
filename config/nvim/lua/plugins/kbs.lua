require 'vimp'

vimp.nmap({'silent'}, '<leader>kd', ':%!AWS_PROFILE=kbs-iam decrypt-file %<CR>:w<CR>')
vimp.nmap({'silent'}, '<leader>ke', ':%!AWS_PROFILE=kbs-iam decrypt-file --command=encrypt %<CR>:e!<CR>')
vimp.nmap({'silent'}, '<leader>kpd', ':%!AWS_PROFILE=kbs-iam decrypt-file --environment=production %<CR>:w<CR>')
vimp.nmap({'silent'}, '<leader>kpe', ':%!AWS_PROFILE=kbs-iam decrypt-file --environment=production --command=encrypt %<CR>:e!<CR>')
