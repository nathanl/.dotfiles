" Use soft wrapping
set wrap textwidth=0 linebreak spell
setlocal formatexpr=CleanedSentencePerLine(v:lnum,v:lnum+v:count-1)
