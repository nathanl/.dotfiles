" Debug this?
function! SentencePerLine(start, end)
  silent execute a:start.','.a:end.'s/\n\s\+/ /'
  silent execute 's/[.!?]\zs /\r/'
endfunction
