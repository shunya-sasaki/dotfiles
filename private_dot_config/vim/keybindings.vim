" vim-floaterm (external program) -----------------------------------------------
" lazygit
nnoremap <silent> <Leader>g :FloatermNew --autoclose=2 --height=0.95 --width=0.95 lazygit<CR>
" yazi
nnoremap <silent> <leader>e :FloatermNew --autoclose=2 --opener=edit --height=0.95 --width=0.95 yazi<CR>

" easy motion (external plugin)-----------------------------------------------
map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map <Leader>s <Plug>(easymotion-s2)
map <Leader>/ <Plug>(easymotion-sn)

" Expand snippet
imap <expr> <CR> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<CR>'
smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'

" Jump forward/backward in snippet placeholders
imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

" fzf (external plugin) --------------------------------------------------------
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fg :Rg<CR>
