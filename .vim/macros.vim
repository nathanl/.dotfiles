" :source (this file) to make these macros available

function UseUnixLineBreaks()
  :%s//\r/g
endfunction

" Type :Linebreak to use this
command Linebreak call UseUnixLineBreaks()

function ReplaceTabsWithSpaces()
  :%s/	/  /g
endfunction

" Type :Softtabs to use this
command Softtabs call ReplaceTabsWithSpaces()
