function UseUnixLineBreaks()
  :%s//\r/g
endfunction

map <Leader>l :call useUnixLineBreaks()<CR>  
