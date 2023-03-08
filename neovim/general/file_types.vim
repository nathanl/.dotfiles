" Don't wrap in the middle of a word in Markdown or text files
au BufNewFile,BufRead *.md,*.txt set linebreak

" Properly detect Elixir and heex files
" https://github.com/elixir-editors/vim-elixir/issues/562
" Note: `:MixFormat` doesn't work on all these: https://github.com/mhinz/vim-mix-format/pull/43
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir
