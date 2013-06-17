augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
" autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
"       \ if &ft =~# '^\%(conf\|modula2\)$' |
"       \   set ft=markdown |
"       \ else |
"       \   setf markdown |
"       \ endif
