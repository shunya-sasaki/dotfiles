" vim-airline (external plugin) ------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tokyonight'
let g:airline_skip_empty_sections = 1
" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
" extensions
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
" sections
let g:airline_section_z = '%p%% %l:%c'
let g:airline_section_y = '%{&fenc!=#""?&fenc:&enc} %{&ff}'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.colnr = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = ''
