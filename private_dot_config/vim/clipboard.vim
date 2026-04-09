" clipboard

set clipboard=

function! YankToOSC52(text)
  let l:b64 = system('base64 | tr -d "\n"', a:text)
  if $TMUX != ''
    let l:osc = "\x1bPtmux;\x1b\x1b]52;c;" . l:b64 . "\x07\x1b\\"
  else
    let l:osc = "\x1b]52;c;" . l:b64 . "\x07"
  endif
  call system("printf '%s' " . shellescape(l:osc) . " > /dev/tty")
endfunction
augroup OSCYankAuto
  autocmd!
  autocmd TextYankPost * if v:event.operator ==# 'y' | call YankToOSC52(join(v:event.regcontents, "\n")) | endif
augroup END
