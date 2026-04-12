" filetype
autocmd FileType text setlocal textwidth=0
augroup GitAttributesFiletype
  autocmd!
  autocmd BufNewFile,BufRead .gitattributes set filetype=gitattributes
  autocmd BufNewFile,BufRead dot_zshrc set filetype=zsh
  autocmd BufNewFile,BufRead dot_bashrc set filetype=sh
  autocmd BufNewFile,BufRead *.jsonc set filetype=jsonc
augroup END

