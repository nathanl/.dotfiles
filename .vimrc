" Canonical version of this file and of the .vim directory is in git
" at git@github.com:nathanl/dotfiles.git
" 
" **************** BASIC SETTINGS ******************  
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Remove all autocommands, in case we are sourced twice.  That's what vim's
" help says to do if you use autocommands, so I'm doing it.
autocmd!

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set showtabline=2 " Always show tab line even when only one tab is open.
set showcmd       " display incomplete commands

" Turn on syntax highlighting, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Do proper indenting per language.  There is a directory full of indenting
" rules that gets installed with vim, like python.vim and ruby.vim; mine was
" /usr/share/vim/vim72/ftplugin/.
filetype plugin indent on 

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" When creating new files, use a template if we have one in templates/
autocmd BufNewFile * silent! 0r ~/.vim/templates/template.%:e

" ****************** SCROLLING *********************  

set scrolloff=8      " Number of lines from vertical edge to start scrolling
set sidescrolloff=15 " Number of cols from horizontal edge to start scrolling
set sidescroll=1     " Number of cols to scroll at a time

" ****************** SEARCHING *********************  
set incsearch     " do incremental searching
set ignorecase    " do case-insensitive searches
set smartcase     " ... unless the search contains upper-case characters
set hlsearch      " highlight all matched terms
" Pressing return clears highlighted search
:nnoremap <CR> :nohlsearch<CR>/<BS>

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" **************** CONVENIENCE MAPPINGS ************  
" Ctrl-L recolors the screen when it gets confused.
noremap <c-l> <c-l>:syntax sync fromstart<CR>
inoremap <c-l> <esc><c-l>:syntax sync fromstart<CR>a

" If you type :W<cr>, save anyway.
command! W w

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" ctrl+w ctrl+w in insert mode should do the same thing as in normal mode
" (change windows)
imap <C-w><C-w> <esc><C-w><C-w>

" ***************** TABS ***************************  
" Usually, you want 2 spaces per tab, so these lines make this the default.
" There are ways to make vi do clever things with tabs in different
" situations, like MS Word can, but I *always* want tab to behave the same way
" -- so I set all three of these tab-related values the same.
" (To overrride these per file type, put commands in .vim/ftplugin/)
set tabstop=2
set softtabstop=2
set shiftwidth=2

set expandtab " insert spaces instead of tab characters
set smarttab  " backspace over a tab will remove a tab's worth of space

" *********** DISPLAYING HIDDEN CHARACTERS *********  
" Beautify display of hidden characters (tabs and line breaks)
" (:set list! to show)
set listchars=tab:▸\ ,eol:¬

" *************** Tab completion ****************
" src: http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
" A different approach to completion is here: 
" https://github.com/skwp/dotfiles/blob/master/vimrc
let g:omni_support=1

function! Smart_TabComplete()
  let line = getline('.')                         " curline
  let substr = strpart(line, -1, col('.'))      " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
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

" **************** PLUGINS *************************  
" Set the leader key to comma (normally, it's "\") for easy access to plugins
let mapleader = ","
"
" ************ Pathogen ****************
" Get Pathogen plugin to load other plugins - all files, recursively, from
" the path specified
call pathogen#infect('~/.vim/bundle/active')

" ************ NERDTree ****************
" Leader f opens NERDTree. Mnemonic: f for "Files"
map <unique> <silent> <Leader>f :NERDTreeToggle<CR>

" ************ TaskList ****************
" Leader t opens TaskList. Mnemonic: t for "TODO"
" '<CR>' jumps to highlighted TODO; 'q' quits
map <unique> <silent> <Leader>t <Plug>TaskList

" ************ FuzzyFinder ****************
map <leader>o :FufFile **/<CR>
map <leader>r :FufRenewCache<CR>

let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|swp|png|jpg|gif|psd)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_dir_exclude = '\v(^|[/\\])\.(hg|git|bzr)($|[/\\])|tmp'

" ************** Taglist ************
" Disable it by default because it requires Exuberant CTags.  Delete or
" comment out this line if you have Exuberant CTags installed.
let loaded_taglist = 'manually aborted'


" ************** COLOR SCHEME ************
" Set to Solarized colorscheme which works on lots of platforms and looks nice
syntax enable
set background=dark
" Necessary in mintty for background to be blue, not black, in vim, even
" after setting mintty's terminal colors to solarized's via a script
let g:solarized_termtrans=1
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Let F5 trigger changing Solarized themes
call togglebg#map("<F5>")


" ************** USER-SPECIFIC SECTIONS ************

" ** User-specific sections to keep peace among the nations. (Nathonia has nukes!) **
" Make sure the variable at least exists, so if the external file isn't
" loaded, we get a useful error
let whoami = ""
" Pull the value from an external file
source ~/.currentVimUser.vim
if whoami == "nathan"
  " Wrap text at column 78 in text files.  
  " In code files this will only apply to comments.
  set textwidth=78

  "** When indenting in visual mode, return to visual mode **
  " indent with > or tab
  vmap > >gv
  vmap <tab> >gv
  " outdent with < or shift-tab
  vmap < <gv
  vmap <S-Tab> <gv
  " Shift-tab in insert mode is a backspace (unindent)
  imap <S-Tab> <BS>

  " Use abbreviations defined here
  source ~/.vim/abbreviations

  " Control+h produces a hashrocket
  imap <C-h> <Space>=><Space>

  " Always show line numbers
  set number

  " Move lines up and down
  nmap <C-J> :m +1 <CR>
  nmap <C-K> :m -2 <CR>

  " Duplicate a selection
  " Visual mode: D
  vmap D y'>p

  " Visually select the text that was last edited/pasted with 'gV'
  " (This is based on the standard 'gv', which repeats the last selection)
  nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

  " Inserts the path of the currently edited file into a command
  " Command mode: Ctrl+P
  cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

  " get jslint from http://javascriptlint.com/
  " When writing a file, if there are errors, have Syntastic plugin mark them
  " In order to check Javascript files, you must have the `jsl` executable from here
  " in your path:
  " http://www.javascriptlint.com/download.htm
  let g:syntastic_enable_signs=1
  let g:syntastic_auto_loc_list=1


elseif whoami == "michael"
  " termcolors=256 above breaks colors in mintty.
  unlet g:solarized_termcolors
  colorscheme solarized

  " Pyflakes plugin colors errors as 'SpellBad' which is the same color as
  " strings by default, making them invisible.  Change the color to be
  " readable.
  hi SpellBad ctermbg=3

  " On save of a Python file, strip trailing whitespaces.
  fun! <SID>StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfun
  autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()

  " ************** Taglist ************
  " In order to use this, you must first download the latest .tar.gz from
  " http://ctags.sourceforge.net/, then run
  "   tar xzvf ctags*.tar.gz
  "   cd ctags*
  "   ./configure && sudo make install
  " to install Exuberant CTags.
  "
  " Useful commands:
  "   q close window
  "   <CR> open tag in current window
  "   t open tag in new tab
  "   p preview tag without closing taglist
  "   x maximize or unmaximize the tag window
  "   <space> show prototype of class/function in status line
  "   s sort alphabetically or by order in the file
  "   - + = * Fold/unfold some or all sections
  "   u update the taglist [except updates happens upon opening of the
  "     taglist and since we use Tlist_Close_On_Select it's not that big a
  "     deal]
  " F9 opens/focuses the taglist
  nnoremap <silent> <F9> :TlistOpen<CR>
  " F12 jumps to the taglist entry for the word under my cursor.  I can then
  "     hit enter to go to its definition.  The ^Rs (typed as Ctrl-V Ctrl-R
  "     s) means to recall the text in register s, which we grabbed at the
  "     start via "s.  The \C means to not ignore case, even if we have
  "     set ignorecase.  The '+' expands the fold in case it was in a
  "     different file (since we have Tlist_File_Fold_Auto_Close set to 1.)
  map <F12> "syiw:TlistOpen<CR>/ s\>\C<CR>+
  imap <F12> <esc>l<F12>
  " <CR> or t will close the list -- my screen isn't wide enough for the
  " taglist as well as 2 80-character buffers, so I can't leave taglist
  " open all the time.
  let Tlist_Close_On_Select = 1
  " Even if the taglist is closed, read the tags for the files I edit,
  " so that when I open the taglist, all my files are there instead of just
  " the one I'm currently in.
  let Tlist_Process_File_Always = 1
  " When I open the taglist, fold all but the active window's tags.  I can
  " always hit * to open them all up if I'm looking for something in another
  " file.
  let Tlist_File_Fold_Auto_Close = 1

  " Yes, I want Taglist to work, yes I've installed Exuberant CTags; undo
  " the damage we did earlier in the .vimrc so Taglist will actually load
  unlet loaded_taglist
else
  " Next line is invalid config syntax, as a hacky way of notifying the user.
    You have to set the "whoami" so we can load user-specific section(s).  Create ~/.currentVimUser.vim. Its contents should be something like 'let whoami="nathan"'. You will see this error message each time you start vim, until you do so. (You'll also have to reload .vimrc.)

endif

" If there are any machine-specific tweaks for Vim, load them from the following file.
try 
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry 
