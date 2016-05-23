function! CleanedSentencePerLine(start, end)
  " OnlySingleSpaces(a:start, a:end)
  SentencePerLine(a:start, a:end)
endfunction

function! OnlySingleSpaces(start, end)
  " TODO - figure out how to replace all duplicate spaces with single spaces
  " EXCEPT at the start of a line (preserve indenting)
  return 1
endfunction

" from http://vi.stackexchange.com/a/2848/7702
function! SentencePerLine(start, end)
  " period, dot, or question mark followed by a space.
  " (If it's followed by a newline, we don't need to mess with it.)
  let non_terminal_sentence_pattern = '\(\.\|?\|\!\)\s'
  let non_terminal_sentence_count = Count(a:start, a:end, non_terminal_sentence_pattern)

  let breaks_inserted = 0
  while breaks_inserted < non_terminal_sentence_count
    exe 'normal!' "^)i\<bs>\<cr>"
    let breaks_inserted += 1
  endwhile
endfunction

function! Count(start, end, pattern )
  " Get a string message including the count of the pattern
  redir => cnt
    silent exe a:start . ',' . a:end . 's/' . a:pattern . '//gn'
  redir END

  " Pull actual number out of the string value
  " IDK what the first character is; just ignoring it
  let res = strpart(cnt, 1, stridx(cnt, " ") - 1)
  return res
endfunction
