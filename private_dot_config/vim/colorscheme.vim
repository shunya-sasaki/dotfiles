" colorscheme
augroup TransparentBG
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight Folded ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight! link SpecialKey Comment
augroup END
colorscheme everforest
set fillchars+=eob:\ 
let g:rehash256 = 1
let g:tokyonight_transparent_background = 1
let g:molokai_original = 1

let g:everforest_background = 'hard'
let g:everforest_enable_italic = 1
let g:everforest_transparent_background = 1
