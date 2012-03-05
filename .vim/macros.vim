" :source (this file) to make these macros available

function UseUnixLineBreaks()
  :%s//\r/g
endfunction

" Type :Linebreak to use this
command Linebreak call UseUnixLineBreaks()

function UseAsciiQuotes()
  " I was able to type in these quotes by doing (eg)
  " (insert mode) Control + Vu + 201c
  " You can find out the code for any character using `ga`
  :%s/“/"/g
  :%s/”/"/g
  :%s/‘/'/g
  :%s/’/'/g
endfunction

command UseAsciiQuotes call UseAsciiQuotes()

function ReplaceTabsWithSpaces()
  :%s/	/  /g
endfunction

" Type :Softtabs to use this
command Softtabs call ReplaceTabsWithSpaces()

" Type :FingerTraining to use this

" Train yourself not to move with jklh;
" search, jump or move by word instead
" (If you're using arrows, shame on you.)
function FingerTraining()
  noremap j <ESC>
  noremap k <ESC>
  noremap h <ESC>
  noremap l <ESC>
endfunction

command FingerTraining call FingerTraining()
