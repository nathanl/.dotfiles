" *************** Basic Tab completion ****************
" src: http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
" A different approach to completion is here:
" https://github.com/skwp/dotfiles/blob/master/vimrc
"
" I really don't understand how this works but it does work for
" stuff like "tab complete this text that already exists in this file"
function! Smart_TabComplete()
  let line = getline('.')                         " curline
  let substr = strpart(line, -1, col('.'))        " from start to cursor
  let substr = matchstr(substr, "[^ \t.]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
