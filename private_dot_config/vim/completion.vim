" key map -------------------------------------------------------------------
let mapleader = " "
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
nnoremap <silent> <C-t> :term ++curwin ++noclose<CR>
" vim-vsnip (external plugin) --------------------------------------------------
let g:vsnip_snippet_dirs = [expand('~/.config/snippets')]

" vim-complete (external plugin) -----------------------------------------------
let g:vimcomplete_options = #{
    \ completor: #{ alwaysOn: v:true },
    \ vsnip:     #{ enable: v:true, priority: 11 },
    \ lsp:       #{ enable: v:true, priority: 10 },
    \ buffer:    #{ enable: v:true, priority: 9 }
\ }
autocmd VimEnter * call g:VimCompleteOptionsSet(g:vimcomplete_options)
