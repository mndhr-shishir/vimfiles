" after\ftplugin\c.vim
" indent to previous bracket

" indent to bracket
setlocal cinoptions+=(0
setlocal colorcolumn=+1

let b:match_words = ''
            \ . '\<switch\>:\<case\>:\<default\>,'
            \ . '\<while\>:\<continue\>:\<break\>,'
            \ . '\<if\>:\<else\>'

function! s:Run()
    if len(getqflist()) == 0
        execute '!%<'
    endif
endfunction

nnoremap <buffer> <space>. :silent make <bar> call <SID>Run()<cr><cr>
