" colorscheme
augroup TransparentBG
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight Folded ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
augroup END
colorscheme monokai
set fillchars+=eob:\ 
let g:rehash256 = 1
let g:tokyonight_transparent_background = 1
let g:molokai_original = 1
