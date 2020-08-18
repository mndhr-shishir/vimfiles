" vimrc
" Plugins {{{
" Native {{{
packadd! matchit
" }}}

call plug#begin("E:\\_vimext\\plugs\\")
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'neomake/neomake'
Plug 'lifepillar/vim-mucomplete'
Plug 'justinmk/vim-dirvish'
Plug 'tommcdo/vim-lion'
Plug 'airblade/vim-rooter'
Plug 'Raimondi/delimitMate'
Plug 'ludovicchabant/vim-gutentags', { 'commit': '31c0ead' }
Plug 'ctrlpvim/ctrlp.vim'
" snippet plugins
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'mattn/emmet-vim'
" ft plugins
Plug 'tomtom/tcomment_vim'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'fatih/vim-go'
Plug 'neovimhaskell/haskell-vim'
" colorscheme(s)
Plug 'junegunn/seoul256.vim'
call plug#end()
" }}}

" General {{{

filetype plugin indent on
syntax sync minlines=256

" Toggleables
set autoindent
set autoread
set autowriteall
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set list
set nobackup
set nocursorline
set nofsync
set noshowcmd
set noshowmode
set nosplitright
set nostartofline
set noswapfile
set nowrap
set nowritebackup
set number
set smartcase
set smarttab
set ttyfast
set wildmenu
set splitbelow
set splitright

" Key/value pairs
set backspace=indent,eol,start
set complete-=t,i
set completeopt=menu,menuone,noinsert,noselect
set encoding=utf-8
set formatoptions+=j
set history=1000
set laststatus=2
set listchars=tab:\ \ ,extends:»,precedes:«,nbsp:·,trail:·
set noeb vb t_vb=
set pastetoggle=<F3>
set pumheight=7
set pythonthreedll=python37.dll
set redrawtime=10000
set renderoptions=type:directx
set scrolloff=3
set sessionoptions-=options
set shiftwidth=4
set shortmess+=cFns
set shortmess-=S
set showbreak=↳
set sidescroll=1
set signcolumn=yes
set softtabstop=4
set synmaxcol=200
set tabpagemax=50
set tabstop=4
set textwidth=79
set updatetime=300
set wildignore+=*.zip,*.png,*.jpg,*.gif,*.pdf,*DS_Store*,*\\.git\\*,*\\node_modules\\*,*\\build\\*,*\\__pycache__\\*,package-lock.json
" }}}

" Abbrevs {{{

" change git to Git(vim-fugitive version)
function! AbbrevCmd(cmd, target)
    return (getcmdtype() ==# ':' && getcmdline() ==# a:cmd) ? a:target : a:cmd
endfunction

cnoreabbrev <expr> git AbbrevCmd('git', 'Git')
cnoreabbrev <expr> ver AbbrevCmd('ver', 'verbose')
" }}}

" General Keymaps {{{
let mapleader="\<Space>"

" show highlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>


" skip some symbols (useful when you have autopairs)
inoremap <expr> <s-cr> search('\%#[]>)}''"`]', 'n') ? '<right>' : ''

" choose the first popupmenu selection and goto next line
imap <expr> <cr> pumvisible() ? "\<c-y>\<Plug>delimitMateCR" : "<Plug>delimitMateCR"

" contextual next/prev command
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" close highlights
nnoremap <silent> \<space> :noh<cr>

" write shell commands
nnoremap \\ :!
nnoremap \| :silent !

" toggle case of the word
inoremap <c-k>w <esc>viw~ea
" uppercase word
inoremap <c-k>u <esc>gUiwea
" lowercase word
inoremap <c-k>l <esc>guiwea
" toggle case of the starting letter of a word
inoremap <c-k>b <esc>b~ea

" nearby find and replace
nnoremap c; *``cgn
nnoremap c, #``cgn

" close all splits except the active one
nnoremap <leader>wo :only<cr>

" update buffer
nnoremap <silent> <c-s> :update<cr>
vnoremap <silent> <c-s> <c-c>:update<cr>
inoremap <silent> <c-s> <c-o>:update<cr>

" close buffer
nnoremap <silent> gq :bd<cr>
nnoremap <silent> gQ :bd!<cr>
vnoremap <silent> gq <c-c>:bd<cr>

" switch between alternate buffers
nnoremap <bs> <c-^>
" split alternate buffer
nnoremap <silent> <leader>w<bs> :vsp #<cr>
" vsplit current buffer
nnoremap <silent> <leader>w. :vsp<cr>

" navigate between windows
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <leader>wl <c-w>l
nnoremap <leader>wh <c-w>h

" map fd to escape
inoremap fd <esc>
vnoremap fd <esc>
snoremap fd <esc>
tnoremap fd <c-\><c-n>

" edit vimrc
nnoremap <leader><localleader> :e $MYVIMRC<cr>
vnoremap <leader><localleader> :e $MYVIMRC<cr>
tnoremap <leader><localleader> :e $MYVIMRC<cr>
" source current file
nnoremap <leader><bar> :source %<cr>
" source a part of a file
vnoremap <leader>@ y:@"<cr>
" }}}

" Augroups {{{
" Renu Toggle {{{
augroup ToggleRelativeNumber
    autocmd!
    " autocmd InsertLeave,BufEnter * set relativenumber
    " autocmd InsertEnter,BufLeave * set norelativenumber
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
" }}}
" Autoread {{{
augroup AutoRead
	autocmd!
	" Triger `autoread` when files changes on disk
    " Source:
    " https://unix.stackexchange.com/a/383044
    " https://vi.stackexchange.com/a/13693
    autocmd CursorHold * if getcmdwintype() == '' | checktime | endif
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
	" Notification after file change
    " Source: https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
	autocmd FileChangedShellPost *
		\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl
augroup END
" " }}}
" Django file settings {{{
function DjangoConfig() abort
    setlocal tabstop=2 softtabstop=2 shiftwidth=2 commentstring={#\ %s\ #}
    inoremap <buffer> fj {{  }}<S-left><left>
    inoremap <buffer> fk {%  %}<S-left><left>
endfunction

augroup ft_django
	autocmd!
	autocmd BufNewFile,BufRead *html set ft=htmldjango
	autocmd FileType htmldjango call DjangoConfig()
augroup END
" }}}
" Jsft related settings {{{
augroup ft_jsfamily
	autocmd!
	autocmd BufNewFile,BufRead *.js set ft=javascript.jsx
    autocmd BufNewFile,BufRead .babelrc set ft=json
	autocmd FileType javascript,javascript.jsx,json setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
" }}}
" Vimscript file settings {{{
augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker formatoptions-=o
augroup END
" }}}
" Toggle 'hlsearch' {{{
augroup ToggleIncsearchHl
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
" }}}
" }}}

" Custom functions {{{
" Preserve cursor and scroll position {{{
function! Preserve(command)
    let w = winsaveview()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
    call winrestview(w)
endfunction
" }}}
" Create non-existing folders {{{
" original source: pending...
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}
" Strip whitespace {{{
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
    " Remove whitespace
	%s/\s\+$//e
	call cursor(l, c)
endfun

" autocmd BufWritePre * call <SID>StripTrailingWhitespaces()
nnoremap <silent> <leader>y :call <SID>StripTrailingWhitespaces()<cr>
" }}}
" Swap lines {{{
" Source: vimwiki
function! MoveLineUp()
  call MoveLineOrVisualUp(".", "")
endfunction

function! MoveLineDown()
  call MoveLineOrVisualDown(".", "")
endfunction

function! MoveVisualUp()
  call MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction

function! MoveVisualDown()
  call MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction

function! MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
	let move_arg = "0"
  else
	let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
	let move_arg = "$"
  else
	let move_arg = a:line_getter." +".v:count1
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction

nnoremap <silent> <a-k> :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <a-j> :<C-u>call MoveLineDown()<CR>
inoremap <silent> <a-k> <C-o>:call MoveLineUp()<CR>
inoremap <silent> <a-j> <C-o>:call MoveLineDown()<CR>
xnoremap <silent> <a-k> :<C-u>call MoveVisualUp()<CR>
xnoremap <silent> <a-j> :<C-u>call MoveVisualDown()<CR>
"vnoremap <silent> <A-k> :<C-u>call MoveVisualUp()<CR>
"vnoremap <silent> <A-j> :<C-u>call MoveVisualDown()<CR>
" }}}
" Better Grep {{{
" Source: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
set grepprg=rg\ --vimgrep\ --no-heading\ --no-messages\ --smart-case\ --glob\ \"!main.js\"
set grepformat^=%f:%l:%c:%m

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

" Commands
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

" Abbreviations
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" Keymaps
" current buffer only
nnoremap yr :let @s=expand('<cword>')<cr>:LGrep \b<C-r>s\b\ %<CR>
nmap cyr yr :redraw<cr>:lfdo %s/\<<C-r>s\>//gI <bar> update<S-left><left><S-left><left><left><left><left>

" project wide
nnoremap yR :let @s=expand('<cword>')<cr>:Grep \b<C-r>s\b<CR>
nmap cyR yR :redraw<cr>:cfdo %s/\<<C-r>s\>//gI \| update<S-left><left><S-left><left><left><left><left>

" Autocommands
augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
    autocmd FileType qf if mapcheck('gq', 'n') ==# '' | nnoremap <buffer><silent> gq :cclose<bar>lclose<CR> | endif
augroup END
" }}}
" Get Hlgroup attribute hex value {{{
function! GetHex(group, attr)
    return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

command -nargs=1 -complete=highlight Bg echo GetHex(<f-args>, "bg")
command -nargs=1 -complete=highlight Fg echo GetHex(<f-args>, "Fg")
" }}}
" }}}

" Plugin config {{{
" Ctrlp {{{
" let g:ctrlp_user_command       = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_user_command        = 'fd --type f --color never --hidden --exclude ".git" "" %s'
let g:ctrlp_cmd                 = 'CtrlP'
let g:ctrlp_map                 = '<leader>e'
let g:ctrlp_working_path_mode   = 'ra'
let g:ctrlp_show_hidden         = 1
let g:ctrlp_use_caching         = 1
let g:ctrlp_clear_cache_on_exit = 1

" Keymaps
nnoremap <leader>E :CtrlPMRUFiles<cr>
nnoremap <leader>o :CtrlPBufTag<cr>
nnoremap <leader>a :CtrlPBuffer<cr>
" }}}

" Dirvish {{{
" Config
let g:loaded_netrwPlugin = 1
let g:dirvish_relative_paths = 1
let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'

" Commands
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" Autcommands
augroup my_dirvish_events
  autocmd!
  autocmd FileType dirvish nnoremap <buffer> + :edit % \| w<left><left><left><left>
  autocmd FileType dirvish nnoremap <buffer> _ :silent !mkdir "%"<left>
augroup END
" }}}

" Emmet {{{
" Config
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
    \  'javascript.jsx' : {
    \      'extends' : 'jsx'
    \  },
    \}

" Keymaps
" let g:user_emmet_expandabbr_key='<C-\>'
" let g:user_emmet_leader_key='<C-j>'

" Function(s)
function EmmetConfig() abort
    EmmetInstall
    imap <buffer> <expr> <C-e> (pumvisible() ? "\<c-y>\<plug>(emmet-expand-abbr)" : "\<plug>(emmet-expand-abbr)")
endfunction

" Autocommands
augroup Emmet
	autocmd!
	autocmd FileType html,htmldjango,jinja,css,javascript,javascript.jsx call EmmetConfig()
augroup END
" }}}

" Gutentags {{{
" Config
" let g:gutentags_ctags_extra_args = ['--options=~\\vimfiles\\ctagsrc']
let g:gutentags_cache_dir='E:\_vimext\.tagCache'
" Ctags Exclude {{{
let g:gutentags_ctags_exclude = [
    \ '.git', '.svg', '.hg',
    \ '/tests/',
    \ 'build',
    \ 'dist',
    \ 'sites//files/',
    \ 'bin',
    \ 'node_modules',
    \ 'venv',
    \ 'public',
    \ 'bower_components',
    \ 'cache',
    \ 'compiled',
    \ 'docs',
    \ 'example',
    \ 'bundle',
    \ 'vendor',
    \ '.md',
    \ '-lock.json',
    \ '.lock',
    \ 'bundle.js',
    \ 'build.js',
    \ '.rc',
    \ '.json',
    \ '.min.',
    \ '.map',
    \ '.bak',
    \ '.zip',
    \ '.pyc',
    \ '.class',
    \ '.sln',
    \ '.Master',
    \ '.csproj',
    \ '.tmp',
    \ '.csproj.user',
    \ '.cache',
    \ '.pdb',
    \ 'tags',
    \ 'cscope.',
    \ '.css',
    \ '.less',
    \ '.scss',
    \ '.exe', '.dll',
    \ '.mp3', '.ogg', '.flac',
    \ '.swp', '.swo',
    \ '.bmp', '.gif', '.ico', '.jpg', '.png',
    \ '.rar', '.zip', '.tar', '.tar.gz', '.tar.xz', '.tar.bz2',
	\ '.pdf', '.doc', '.docx', '.ppt', '.pptx',
    \ ]
" }}}
" }}}

" Neomake {{{
" Config

" Run linting after saving current file
call neomake#configure#automake('w')

" let g:neomake_open_list = 2

let g:neomake_error_sign = {
            \ 'text': "\\ ●",
            \ 'texthl': 'NeomakeErrorSign',
            \ }
let g:neomake_warning_sign = {
            \   'text': "\\ ●",
            \   'texthl': 'NeomakeWarningSign',
            \ }
let g:neomake_message_sign = {
            \   'text': "\\ ●",
            \   'texthl': 'NeomakeMessageSign',
            \ }
let g:neomake_info_sign = {
            \ 'text': "\\ ●",
            \ 'texthl': 'NeomakeInfoSign',
            \ }
" }}}

" Mucomplete {{{
" Config
let g:mucomplete#minimum_prefix_length  = 2
let g:mucomplete#buffer_relative_paths  = 1
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['keyn', 'c-n']

" Keymaps
imap <expr> <c-space> mucomplete#extend_fwd("\<c-space>")
" }}}

" Obsession {{{
" Config
set titlestring=%t%{ObsessionStatus()}
function SessionStatus()
    return ObsessionStatus() ? '(' . ObsessionStatus . ')' : ''
endfunction

let g:sesssions_dir='~\\vimfiles\\sessions\\'

" Keymaps
" create new session
exec 'nnoremap <leader>s :Obsession ' . g:sesssions_dir . '*.vim<C-D><BS><BS><BS><BS><BS>'
" source session
exec 'nnoremap <leader>S :so ' . g:sesssions_dir . '*.vim<C-D><BS><BS><BS><BS><BS>'
" }}}

" Snipmate {{{
" Config
let g:snipMate = {}
let g:snipMate['snippet_version'] = 1
let g:snipMate['no_match_completion_feedkeys_chars'] = ''

" Keymaps
" forward
imap <expr> <c-tab> (pumvisible() ? "\<c-y>" : "")."\<Plug>snipMateNextOrTrigger"
smap <expr> <c-tab> (pumvisible() ? "\<c-y>" : "")."\<Plug>snipMateNextOrTrigger"

" backward
" imap <expr> <S-space> (pumvisible() ? "\<C-y>" : "")."\<Plug>snipMateBack"
" smap <expr> <S-space> (pumvisible() ? "\<C-y>" : "")."\<Plug>snipMateBack"
" }}}

" Rooter {{{
" Config
let g:rooter_silent_chdir = 1
" }}}

" Fugitive {{{
" Keymaps
nnoremap <leader>gg :Gstatus<cr>
nnoremap <leader>g/ :Gvdiffsplit HEAD^<cr>
nnoremap <leader>g% :0Gclog<cr>
" }}}
" }}}

" ColorScheme {{{
" All  {{{
function! CustomHighlights() abort
    highlight SignColumn guibg=NONE
    highlight LineNr     guibg=NONE
    highlight Comment    gui=NONE
    " highlight SpecialKey guibg=NONE
    " highlight Folded     gui=BOLD
    " highlight NonText    gui=NONE
    " hi MatchParen gui=bold,underline guibg=NONE
endfunction
" }}}
" Seoul-256 {{{
function! CustomSeoul() abort
    call CustomHighlights()

    if g:colors_name ==# 'seoul256'
        highlight StatusLine   cterm=bold,reverse   ctermfg=95 ctermbg=234 gui=bold guifg=#987372 guibg=#252525
        highlight StatusLineNC cterm=bold,underline ctermfg=95 ctermbg=234 gui=NONE guifg=#727272 guibg=#252525
        " highlight StatusLineNC cterm=bold,underline ctermfg=95 ctermbg=234 gui=italic guifg=#987372 guibg=#252525

        " inbuilt terminal ColorScheme
        let g:terminal_ansi_colors = [
                    \ "#4e4e4e",
                    \ "#d68787",
                    \ "#5f865f",
                    \ "#d8af5f",
                    \ "#85add4",
                    \ "#d7afaf",
                    \ "#87afaf",
                    \ "#d0d0d0",
                    \ "#626262",
                    \ "#d75f87",
                    \ "#87af87",
                    \ "#ffd787",
                    \ "#add4fb",
                    \ "#ffafaf",
                    \ "#87d7d7",
                    \ "#e4e4e4",
                    \ ]
    else
        let g:terminal_ansi_colors = [
                    \ "#4e4e4e",
                    \ "#af5f5f",
                    \ "#5f885f",
                    \ "#af8760",
                    \ "#5f87ae",
                    \ "#875f87",
                    \ "#5f8787",
                    \ "#e4e4e4",
                    \ "#3a3a3a",
                    \ "#870100",
                    \ "#005f00",
                    \ "#d8865f",
                    \ "#0087af",
                    \ "#87025f",
                    \ "#008787",
                    \ "#eeeeee",
                    \ ]
    endif

    highlight NeoMakeErrorSign      gui=BOLD guifg=#E12672
    highlight NeoMakeWarningSign    gui=BOLD guifg=#DFBC72
    highlight NeoMakeMessageSign    gui=BOLD guifg=#719872
    highlight NeoMakeInfoSign       gui=BOLD guifg=#98BCBD

endfunction
" }}}

" Autocommands
augroup CustomColorscheme
    autocmd!
    autocmd ColorScheme seoul256,seoul256-light call CustomSeoul()
augroup END

set background=dark
let g:python_highlight_all=1
" let g:seoul256_background=234
let g:seoul256_background=234
let g:seoul256_light_background = 255
color seoul256
" }}}

" Statusline {{{
" (dict) Modes {{{
let s:modes= {
            \ 'n'  	    : 'normal',
            \ 'i'  	    : 'insert',
            \ 'v'  	    : 'visual',
            \ 'V'  	    : 'v-line',
            \ "\<C-v>"	: 'v-block',
            \ 's' 		: 'select',
            \ 'S' 		: 's-line',
            \ 'R' 		: 'replace',
            \ 'Rv'		: 'v-replace',
            \ 'c' 		: 'command',
            \ 'cv'		: 'vim Ex',
            \ 'ce'		: 'ex',
            \ 'r'		: 'prompt',
            \ 'rm'		: 'more',
            \ 'r?'		: 'confirm',
            \ '!' 		: 'shell',
            \ 't' 		: 'terminal',
            \ }
" }}}

" (fn)Current mode {{{
function! CurrentMode()
    return &paste ? s:modes[mode()] . '(paste)' : s:modes[mode()]
endfunction
" }}}
" (fn)Current git branch {{{
function! GitBranch()
    let git = fugitive#head()
    if git != ""
        return "\ ".fugitive#head()." ❯"
    endif
    return ""
endfunction
" }}}
" (fn)Linter Info {{{
function! NeomakeLinterInfo()
    let linterInfo = neomake#statusline#LoclistCounts()
    let linteInfoStr = ''
    if linterInfo->empty()
        return linteInfoStr
    endif

    for key in keys(linterInfo) 
        let linteInfoStr .= tolower(key) . ':' . linterInfo[key] . ' '
    endfor
    return "\ " . linteInfoStr . "❯"
endfunction
" }}}
" (fn)Show Filetype {{{
function! ShowFt() 
    if &filetype !=# ''
        return '❮ '.&filetype
    endif
    return ''
endfunction

" }}}

" Statusline format {{{
set statusline=
" set statusline+=%#LineNr#
set statusline+=\ %{CurrentMode()}
set statusline+=\ ❯
set statusline+=%{GitBranch()}
set statusline+=\ %{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ name]'}
set statusline+=%m%r\ ❯
set statusline+=%{NeomakeLinterInfo()}
set statusline+=%=
set statusline+=%{ShowFt()}\ "
" }}}
" }}}
