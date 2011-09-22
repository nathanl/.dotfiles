" :source (this file) to make these macros available

function UseUnixLineBreaks()
  :%s//\r/g
endfunction

" Type :Linebreak to use this
command Linebreak call UseUnixLineBreaks()
