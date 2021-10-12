" Set the leader key to comma (normally, it's "\")
let mapleader = ","

syntax enable " Enable syntax highlighting
set t_Co=256                            " Support 256 colors
set showtabline=2                       " Always show tabs
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set clipboard=unnamedplus               " Copy paste between vim and everything else
set mouse=a                             " Enable your mouse
set cmdheight=1                         " Increase for more space for displaying messages
set iskeyword+=-                     	 " treat dash separated words as a word text object"
set noswapfile                          " Don't use swap files
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set termguicolors

" Captial Q does nothing (instead of entering Ex mode)
nnoremap Q <nop>

" put custom executables on the path
let $PATH = expand("~/.dotfiles/bin") . ":" . $PATH

" **** Searching ****
set ignorecase    " do case-insensitive searches
set smartcase     " ... unless the search contains upper-case characters


" ****************** SPLITTING *********************
set splitright " vsplit makes new pane to the right (not left)
set splitbelow " split  makes new pane below (not above)


" ****************** Scrolling *********************  

set scrolloff=8      " Number of lines from vertical edge to start scrolling
set sidescrolloff=15 " Number of cols from horizontal edge to start scrolling
set sidescroll=1     " Number of cols to scroll at a time

" ***************** Tabs ***************************  
set tabstop=2     " visual spaces displayed per tab character
set expandtab     " insert spaces instead of tab characters
set softtabstop=2 " spaces entered when tab key is pressed
set shiftwidth=2  " spaces for auto-intent or <</>>
set smarttab      " backspace over a tab will remove a tab's worth of space

" *********** Displaying Hidden Characters *********
" Beautify display of hidden characters (tabs, line breaks, etc).
" (`:set list!` to toggle display; `:help listchars` for info )
set listchars=nbsp:☠,trail:⋅,tab:▸\ ,eol:¬,extends:❯,precedes:❮


if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" Cursor with mode shapes and blinking, from :help guicursor
:set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" More settings that may be useful:
" https://www.chrisatmachine.com/Neovim/02-vim-general-settings/

" set hidden                              " Required to keep multiple buffers open multiple buffers
" set nowrap                              " Display long lines as just one line
" set pumheight=10                        " Makes popup menu smaller
" set conceallevel=0                      " So that I can see `` in markdown files
" set smartindent                         " Makes indenting smart
" set autoindent                          " Good auto indent
" set background=dark                     " tell vim what the background color looks like
" set updatetime=300                      " Faster completion
" set timeoutlen=500                      " By default timeoutlen is 1000 ms
" set formatoptions-=cro                  " Stop newline continution of comments
" "set autochdir                           " Your working directory will always be the same as your working directory
