" c.vim
function! s:Run()
    if len(getqflist()) == 0
        execute '!%<'
    endif
endfunction

nnoremap <buffer> <space>. :silent make <bar> call <SID>Run()<cr><cr>
