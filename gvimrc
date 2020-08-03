set guifont=mononoki:h11
set guicursor+=a:blinkon0
set linespace=1
set guioptions=

augroup GvimCfg
    autocmd!
    " Maximize the gvim window at startup
    autocmd GUIEnter * simalt ~x
    " disable annoying beeps/visual bells
    autocmd GUIEnter * set vb t_vb=
    " autocmd GuiEnter * silent exec 'call libcallnr("E:\\Creation applications\\devTools\\vim\\vim82\\vimtweak64.dll", "SetAlpha", 248)'
augroup END
