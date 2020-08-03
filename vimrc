" vimrc
" Plugins {{{
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
syntax sync minlines=256 "opt

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
set nostartofline
set noswapfile
set nowritebackup
set nowrap
set number
set smartcase
set smarttab
set ttyfast
set wildmenu
set splitright
set nosplitbelow

" Key/value pairs
set showbreak=↳
set backspace=indent,eol,start
set complete-=t,i
set completeopt=menu,menuone,noinsert,noselect
set encoding=utf-8
set history=1000
set laststatus=2
set listchars=tab:\ \ ,extends:»,precedes:«,nbsp:·,trail:·
set noeb vb t_vb=
set pumheight=7
set redrawtime=10000
set rop=type:directx
set scrolloff=3
set sessionoptions-=options
set shortmess+=cFns
set shortmess-=S
set sidescroll=1
set signcolumn=number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set synmaxcol=200
set tabpagemax=50
set updatetime=300
set wildignore+=*.zip,*.png,*.jpg,*.gif,*.pdf,*DS_Store*,*\\.git\\*,*\\node_modules\\*,*\\build\\*,*\\__pycache__\\*,package-lock.json
set pythonthreedll=python37.dll
" }}}

" Abbrevs {{{
cabbrev verb verbose
" }}}

" Keymaps {{{
let mapleader="\<Space>"

" show highlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" skip some symbols (useful when you have autopairs)
inoremap <expr> <S-enter> search('\%#[]>)}''"`]', 'n') ? '<right>' : ''

" discard popupmenu selection and goto next line
imap <expr> <cr> pumvisible() ? "\<c-e>\<Plug>delimitMateCR" : "<Plug>delimitMateCR"

" command line completion
cnoremap <c-tab> <c-d>

" close quickfix on <c-z>
nnoremap <silent> <c-z> :ccl<cr>

" write shell command
nnoremap \\ :!
nnoremap \| :silent !

" toggle case
inoremap <c-k> <esc>viw~ea

" some remappings
nnoremap <tab> %

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
nnoremap <leader><leader> <C-^>

" navigate between windows
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <leader>wl <c-w>l
nnoremap <leader>wh <c-w>h

" map fd to escape
inoremap fd <esc>
vnoremap fd <esc>
snoremap fd <esc>
nnoremap <esc> :noh<cr>

" edit vimrc and source current file
nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap <leader>V :source %<cr>
" }}}

" Augroups {{{
" Renu Toggle {{{
augroup ToggleRelativeNumber
    autocmd!
    autocmd InsertLeave,BufEnter,FocusGained * set relativenumber
    autocmd InsertEnter,BufLeave,FocusLost   * set norelativenumber
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
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Search highlight settings {{{
augroup vimrc-incsearch-highlight
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
" Create directories if they don't exis {{{
" original source: pending...
function s:MkNonExDir(file, buf)
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

nnoremap <silent> <A-k> :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <A-j> :<C-u>call MoveLineDown()<CR>
inoremap <silent> <A-k> <C-o>:call MoveLineUp()<CR>
inoremap <silent> <A-j> <C-o>:call MoveLineDown()<CR>
xnoremap <silent> <A-k> :<C-u>call MoveVisualUp()<CR>
xnoremap <silent> <A-j> :<C-u>call MoveVisualDown()<CR>
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

" Vim-go {{{
" Config
" let g:neomake_go_enabled_makers = []
let g:go_imports_mode                        = "goimports"

let g:go_echo_go_info                        = 0
let g:go_gopls_enabled                       = 0
let g:go_diagnostics_enabled                 = 0
let g:go_echo_command_info                   = 0
let g:go_fmt_autosave                        = 0
let g:go_template_autocreate                 = 0
let g:go_def_mapping_enabled                 = 0

" syntax highlights
let g:go_highlight_types                     = 1
let g:go_highlight_operators                 = 1
let g:go_highlight_format_strings            = 1
let g:go_highlight_functions                 = 1
let g:go_highlight_function_calls            = 1
let g:go_highlight_function_parameters       = 0
let g:go_highlight_diagnostic_errors         = 0
let g:go_highlight_diagnostic_warnings       = 0
let g:go_highlight_trailing_whitespace_error = 0

" Keymaps
function s:GoKeyMaps()
    nnoremap <silent> <buffer> <localleader>. :GoRun<cr><cr>
    nnoremap <silent> <buffer> <localleader>? :GoImports<cr>
endfunction

" Autocmds
augroup Go
    autocmd!
    autocmd FileType go call <SID>GoKeyMaps()
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

let g:neomake_open_list = 2

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
imap <expr> <c-tab> mucomplete#extend_fwd("\<c-tab>")
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
imap <expr> <C-space> (pumvisible() ? "\<C-y>" : "")."\<Plug>snipMateNextOrTrigger"
smap <expr> <C-space> (pumvisible() ? "\<C-y>" : "")."\<Plug>snipMateNextOrTrigger"

" backward
" imap <expr> <S-space> (pumvisible() ? "\<C-y>" : "")."\<Plug>snipMateBack"
" smap <expr> <S-space> (pumvisible() ? "\<C-y>" : "")."\<Plug>snipMateBack"
" }}}

" Rooter {{{
" Config
let g:rooter_silent_chdir = 1
" }}}
" }}}

" ColorScheme {{{
" All  {{{
function! CustomHighlights() abort
    hi SignColumn guibg=NONE
    hi LineNr     ctermbg=NONE       guibg=NONE
    hi Comment    gui=NONE
    hi NonText    gui=NONE
    hi SpecialKey guibg=NONE
    " hi MatchParen gui=bold,underline guibg=NONE
endfunction
" }}}
" Apprentice {{{
function! CustomApprentice() abort
    call CustomHighlights()

    hi link htmlArg Type

    hi NeoMakeErrorSign   ctermfg=235 ctermbg=131 guifg=#af5f5f guibg=#262626
    hi NeoMakeWarningSign ctermfg=235 ctermbg=229 guifg=#ffffaf guibg=#262626
    hi NeoMakeMessageSign ctermfg=108 ctermbg=235 guifg=#87af87 guibg=#262626
    hi NeoMakeInfoSign    ctermfg=110 ctermbg=235 guifg=#8fafd7 guibg=#262626
endfunction
" }}}
" Seoul-256 {{{
function! CustomSeoul() abort
    call CustomHighlights()

    if g:colors_name ==# 'seoul256' 
        hi    StatusLine    cterm=bold,reverse ctermfg=95           ctermbg=234 gui=bold,reverse guifg=#987372    guibg=#252525
        hi    StatusLineNC  cterm=bold,underline         ctermfg=95           ctermbg=234 gui=bold,underline         guifg=#987372    guibg=#252525

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
    endif

    hi NeoMakeErrorSign   guifg=#E12672
    hi NeoMakeWarningSign guifg=#DFBC72
    hi NeoMakeMessageSign guifg=#719872
    hi NeoMakeInfoSign    guifg=#98BCBD

endfunction
" }}}
" Silkworm {{{
function! CustomSilkworm() abort
    hi    NonText          guibg=NONE
    hi    SpecialKey       guibg=NONE
    hi    StorageClass     gui=NONE
    hi    Identifier       gui=NONE
    hi    VertSplit        gui=NONE
    hi    link             Search            Pmenu
    hi    IncSearch        gui=NONE          guibg=#367a7f
    hi    WarningMsg       term=standout     ctermfg=4          gui=bold guifg=#76690b guibg=#d9d1c9
    hi    link             Error             ErrorMsg
    hi    StatusLineNC     term=bold,reverse cterm=bold,reverse gui=bold guifg=#656565 guibg=#ece3db
endfunction
" }}}
" Plain {{{
function CustomPlain() abort
    call CustomHighlights()
    hi! link Search VisualNOS
    hi! link IncSearch Visual
    hi! link Type Statement
    hi! link LineNr Comment
    hi! link Todo StatusLineError
    hi! link cDefine Statement
endfunction
" }}}

" Autocommands
augroup CustomColorscheme
    autocmd!
    autocmd ColorScheme seoul256,seoul256-light call CustomSeoul()
augroup END

let g:python_highlight_all=1
let g:seoul256_background=234
set background=dark
color seoul256
" }}}

" Statusline {{{
" Modes
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
            \ 't' 		: 'terminal'
            \}

" get current git branch
function! GitInfo()
    let git = fugitive#head()
    if git != ''
        return '('.fugitive#head().') '
    else
        return ''
    endif
endfunction

" get current vim mode
function! CurrentMode()
    return '  '.s:modes[mode()].' '
endfunction

" format
set statusline=
set statusline+=%{CurrentMode()}
set statusline+=\§\ %{GitInfo()}
set statusline+=%{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
set statusline+=%m\ %r
set statusline+=%#SpecialKey#
set statusline+=\ %=
set statusline+=%{&filetype}\ "
" }}}

" Source *.vim files {{{
" for f in glob('~\\vimfiles\\plugsrc\\*.vim', 0, 1)
"     execute 'source' f
" endfor
" }}}
