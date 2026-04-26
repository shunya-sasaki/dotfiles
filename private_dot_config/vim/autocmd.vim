augroup LspFormatOnSave
  autocmd!
  autocmd User LspAttached {
    var ft = &filetype
    var format_fts = ['python', 'typescript', 'typescriptreact', 'rust', 'cpp', 'c']
    if format_fts->index(ft) >= 0
      autocmd BufWritePre <buffer> silent! LspFixAll
      autocmd BufWritePre <buffer> silent! LspOrganizeImports
      autocmd BufWritePre <buffer> silent! LspFormat
    endif
  }
augroup END
