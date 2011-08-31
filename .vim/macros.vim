function! FOO()
  " Silly example function - change the current word
  " to whatever is in register a
  normal ciwa
endfunction

map <Leader>ss :call FOO()<cr>
