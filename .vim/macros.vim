function UseUnixLineBreaks()
  :%s/
endfunction

map <Leader>linebreak :call UseUnixLineBreaks()<CR>  