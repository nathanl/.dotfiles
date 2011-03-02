set guioptions-=T " hide toolbar
set lines=68 columns=128

colorscheme railscasts

highlight LineNr ctermfg=grey ctermbg=black guibg=black guifg=grey

set guifont=DejaVu\ Sans\ Mono:h13

" When highlighting search terms, make sure text is contrasting colors
:highlight Search guibg=yellow guifg=black

" Better highlighting of matching braces
hi MatchParen guibg=blue guifg=black

" Invisible character colors - see http://vimcasts.org/episodes/show-invisibles/
:highlight NonText guifg=#4a4a59
:highlight SpecialKey guifg=#4a4a59
