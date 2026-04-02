" Don't wrap in the middle of a word in Markdown or text files
au BufNewFile,BufRead *.md,*.txt set linebreak

" Word count and reading time in statusline for markdown files
function! WordCount()
  return wordcount()['words'] . 'w'
endfunction

function! ReadingTime()
  " Words per minute for spoken delivery. 130 wpm is a deliberate pace suited
  " for sermons and formal speeches. Conversational speaking runs 150-170 wpm;
  " silent reading is typically 200-250 wpm.
  let l:wpm = 130
  let l:secs = float2nr(ceil(wordcount()['words'] * 60.0 / l:wpm))
  let l:h = l:secs / 3600
  let l:m = (l:secs % 3600) / 60
  let l:s = l:secs % 60
  if l:h > 0
    return printf('%dh%02dm%02ds', l:h, l:m, l:s)
  elseif l:m > 0
    return printf('%dm%02ds', l:m, l:s)
  else
    return printf('%ds', l:s)
  endif
endfunction

au BufNewFile,BufRead *.md setlocal statusline=%f\ %m%=%{WordCount()}\ %{ReadingTime()}\ \ %l:%c\

" Properly detect Elixir and heex files
" https://github.com/elixir-editors/vim-elixir/issues/562
" Note: `:MixFormat` doesn't work on all these: https://github.com/mhinz/vim-mix-format/pull/43
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir
