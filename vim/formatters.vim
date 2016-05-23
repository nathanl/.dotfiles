" from http://vi.stackexchange.com/a/2848/7702
function! SentencePerLine(start, end)

  let eos_pattern = '\(\.\|?\|\!\)\s'
  redir => cnt
    silent exe a:start . ',' . a:end . 's/' . eos_pattern . '//gn'
  redir END
  " Pull actual number out of the string value
  let yeoldcounte = strpart(cnt, 1, stridx(cnt, " ") - 1)
  " Convert it to a number for valid comparison
  let yeoldcounte = str2nr(yeoldcounte)
  " echom "cnt is " cnt . ", count is " . yeoldcounte

  " :exe 'normal!' "^"
  let yeoldeiters = 0
  echom "iters is " . iters . " and count is " . yeoldcounte . " so is iters less? " . (yeoldeiters < yeoldcounte)
  while yeoldeiters < yeoldcounte
    :exe 'normal!' "^)i\<bs>\<cr>"
    " echom "oh wat"
    let yeoldeiters += 1
  endwhile
endfunction

" TODO make a separate 'remove repeated spaces not at beginning of line' and
" compose them

" function! Count(start, end, pattern )
"   " Get a string message including the count of the pattern
"   redir => cnt
"     silent exe a:start . ',' . a:end . 's/' . a:pattern . '//gn'
"   redir END
"
"   " Pull actual number out of the string value
"   let res = strpart(cnt, 1, stridx(cnt, " "))
"   " echom "res is " . res
"   return res
" endfunction
"
" " function! DumbThing()
" "   let someval = Returnerer()
" "   echom "I got " . someval
" "   return "oh yayer"
" " endfunction
" "
" " function! Returnerer()
" "   return 99
" " endfunction
" function! DumbLoop()
"   let counterthing = 0
"   while counterthing < 2
"     echom "increasing it"
"     let counterthing += 1
"   endwhile
"   echom "now it is " . counterthing
" endfunction
