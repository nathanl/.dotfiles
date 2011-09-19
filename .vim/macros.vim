function UseUnixLineBreaks()
  :%s//\r/g
endfunction

map <Leader>linebreak :call UseUnixLineBreaks()<CR>  
