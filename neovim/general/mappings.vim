" reload .vimrc
map <leader>rc :source ~/.config/nvim/init.vim <cr>

" copy current relative filename into clipboard
map <leader>n :let @+ = expand("%")<cr>

" copy current absolute filename into clipboard
map <leader>an :let @+ = expand("%:p")<cr>

" Enter in normal mode clears highlighted search terms
nnoremap <silent> <CR> :noh

" Make Y behave like other capitals - to end of line
map Y y$

" Render the current markdown file as HTML
map <leader>md :!md_preview '%'<cr>
" Also open the HTML file
map <leader>mo :!md_preview '%' open<cr>

" Run `mix format` on the current file via the plugin vim-mix-format
map <Leader>mf :MixFormat<CR>

" SQL format the current file
" (requires `pip install sqlparse` and `asdf reshim`)
map <leader>sql :%!sqlformat --reindent --keywords upper --identifiers lower -<CR>

" add a datestamp or timestamp
map <leader>ds :read !datestamp<cr>
map <leader>ts :read !timestamp<cr>

map <leader>ca :read ~/.dotfiles/git/co-author-template.txt<cr>

" Format Blue Letter Bible quotations as blockquotes with reference at end
map <leader>blb ^"rda[i>V:s/\%V\d\{1,\}\s//g<cr>A ("rpds[A)^

"** When indenting in visual mode, return to visual mode **
" indent with > or tab
vmap > >gv
vmap <tab> >gv
" outdent with < or shift-tab
vmap < <gv
vmap <S-Tab> <gv

" Ctrl-L recolors the screen when it gets confused.
noremap <c-l> <c-l>:syntax sync fromstart<CR>
inoremap <c-l> <esc><c-l>:syntax sync fromstart<CR>a

" `leader w` in normal mode saves file.
nmap <leader>w :w <CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %
