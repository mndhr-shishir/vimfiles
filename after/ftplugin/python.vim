" after\ftplugin\python.vim

setlocal colorcolumn=+1

let b:match_words = ''
            \ . '\<if\>:\<elif\>:\<else\>,'
            \ . '\<try\>:\<except\>\|\<finally\>,'
            \ . '\<True\>:\<False\>'

nnoremap <buffer> <leader>. :silent !py main.py<cr><cr>
nnoremap <buffer> <localleader>. :silent !py %<cr><cr>

" for matchit plugin

" add an empty line (if it doesn't already exist) at the end when saving python files
function! s:AppendEmptyLineAtEOF()
    if getline(line('$')) !=# ''
        call append(line('$'), '')
    endif
endfunction

augroup Python
    autocmd!
    autocmd BufWritePre *.py call s:AppendEmptyLineAtEOF()
augroup END
