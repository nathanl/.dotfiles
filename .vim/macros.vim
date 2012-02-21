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
