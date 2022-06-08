" Relies on https://github.com/junegunn/vim-plug
" :PlugInstall! to install whatever you add
" :PlugUpdate [name] to update a plugin
" Reload config and run :PlugInstall or :PlugClean after modifying this fall
" Plugins get installed in ~/.local/share/nvim/plugged
call plug#begin(stdpath('data') . '/plugged')
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

Plug 'scrooloose/nerdtree'

" ************ CtrlP (File Finder) ****************
Plug 'ctrlpvim/ctrlp.vim'
" - Pressing <control + p> starts it.
" - <ctrl + j/k> moves between matches. 
" - Enter opens. <ctrl + t> opens in same tab (with config below).
" - ctrl+f changes modes. MRU means 'Most Recently Used'. 
" - <ctrl + r> toggles regexp/fuzzy search; regexp is also nice for exact filenames
"
" Open a single file in a new tab by default
let g:ctrlp_prompt_mappings = {'AcceptSelection("e")': ['<c-t>'], 'AcceptSelection("t")': ['<cr>', '2-LeftMouse'], }
" Open new files in a new tab
let g:ctrlp_open_new_file = 't'
" Open multiple files in new tabs and jump to the first one
let g:ctrlp_open_multiple_files = 'tj'
" Search files returned by one of these commands, depending on whether you
" find .git in the directory or not.
" See `:help ctrlp-options`
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
let g:ctrlp_working_path_mode = 0 " respect changes in pwd

Plug 'tomtom/tcomment_vim'

" Align text using delimiters.
" Eg, highlight lines with | separators and type 'Tab /|'
Plug 'godlygeek/tabular'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-markdown'

let g:markdown_fenced_languages = ['html', 'python', 'elixir', 'ruby', 'sh', 'bash=sh', 'zsh=sh', 'sql']

" *** Solarized ***
Plug 'overcache/NeoSolarized'

function! ToggleBg()
  if &background ==# "dark"
    set background=light
  else
    set background=dark
  endif
endfunction
nmap <F5> :call ToggleBg()<CR>

Plug 'elixir-editors/vim-elixir'

" **** Mix Format ****
Plug 'mhinz/vim-mix-format'

" **** Elixir LS Fanciness ****
" language server configurations
" Plug 'neovim/nvim-lspconfig'
" autocomplete and snippets
" Plug 'hrsh7th/nvim-compe'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" Install language server with `:LspInstall <language>`
" into Neovim's default data directory (see :h stdpath)
" eg `:LspIntall elixir`
" Plug 'kabouzeid/nvim-lspinstall'

call plug#end()
