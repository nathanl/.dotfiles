" Use soft wrapping
setlocal wrap textwidth=0 linebreak spell lbr
setlocal formatexpr=CleanedSentencePerLine(v:lnum,v:lnum+(v:count-1))
