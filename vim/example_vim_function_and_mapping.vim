function! GARBAGE()
  " break into lines with comments
  normal /def
  normal ea_jam
endfunction
map <leader>g :call GARBAGE()<cr>
