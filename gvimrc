set guifont=agave:h11
set guicursor+=a:blinkon0
set linespace=1
set guioptions=

augroup GvimCfg
    autocmd!
    " Maximize on the window on opening the GUI app
    autocmd GUIEnter * simalt ~x
    " disable annoying beeps
    autocmd GUIEnter * set vb t_vb=
    " autocmd GuiEnter * silent exec 'call libcallnr("E:\\Creation applications\\devTools\\vim\\vim82\\vimtweak64.dll", "SetAlpha", 248)'
augroup END
