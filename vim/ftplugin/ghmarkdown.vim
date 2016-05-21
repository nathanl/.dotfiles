" Use soft wrapping
setlocal wrap textwidth=0 linebreak spell lbr
set formatexpr=SentencePerLine(v:lnum,v:lnum+v:count-1)
