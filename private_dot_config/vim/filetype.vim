" filetype
autocmd FileType text setlocal textwidth=0
augroup GitAttributesFiletype
  autocmd!
  autocmd BufNewFile,BufRead .gitattributes set filetype=gitattributes
augroup END
