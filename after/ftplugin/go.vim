" after\ftplugin\go.vim

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


nnoremap <silent> <buffer> <localleader>. :GoRun<cr><cr>
nnoremap <silent> <buffer> <localleader>? :GoImports<cr>

