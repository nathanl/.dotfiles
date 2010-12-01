" Canonical version of this file and of the .vim directory is in git
" at git@github.com:sleeplessgeek/dotfiles.git
" 
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Remove all autocommands, in case we are sourced twice.  That's what vim's
" help says to do if you use autocommands, so I'm doing it.
autocmd!

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands

" ****************** Searching ********************
set incsearch   " do incremental searching
set ignorecase  " do case-insensitive searches
set smartcase   " ... unless the search contains upper-case characters
set hlsearch    " highlight all matched terms
" Pressing return clears highlighted search
:nnoremap <CR> :nohlsearch<CR>/<BS>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" C-wC-w should move windows, always.
imap <C-w><C-w> <esc><C-w><C-w>

" Turn on syntax highlighting, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  " Matching braces get the same background and foreground color, making
  " for a very bad UI, unless we change the default colors.
  hi MatchParen ctermbg=blue
endif

" When highlighting search terms, make sure text is contrasting color
:highlight Search ctermbg=yellow ctermfg=black
" Do the same for gvim
:highlight Search guibg=yellow guifg=black

" Do proper indenting per language.  There is a directory full of indenting
" rules that gets installed with vim, like python.vim and ruby.vim; mine was
" /usr/share/vim/vim72/ftplugin/.
filetype plugin indent on 

" Wrap text at column 78, in text files.
autocmd FileType text setlocal textwidth=78

" Wrap text at column 78 in text files.  
" In code files this will only apply to comments.
set textwidth=78

" Always show tab line even when only one tab is open.
set showtabline=2

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Attempt to load a template for the file type we're loading.
autocmd BufNewFile * silent! 0r ~/.vim/templates/template.%:e

" ************** Tabs **************

set smarttab  " backspace over a tab will remove a tab's worth of space

" Most times you want 4 spaces per tab, so these lines make this the default.
" There are ways to make vi do clever things with tabs in different
" situations, like MS Word can, but I *always* want tab to behave the same way
" -- so I set all three of these tab-related values the same.
set tabstop=4
set softtabstop=4
set shiftwidth=4

" text files should put real tabs in, not spaces.
autocmd FileType text set noexpandtab

" HTML and Javascript are better off with 2-space tabs, not 4-space, so we
" override the settings above.
autocmd FileType xhtml,html,javascript set shiftwidth=2
autocmd FileType xhtml,html,javascript set tabstop=2
autocmd FileType xhtml,html,javascript set softtabstop=2

" *************** Tab completion ****************
" If you don't have +ruby compiled into vim, ruby files will barf when
" we tab-complete and try to run omnifunc.  I don't know how to check
" whether we have +ruby support, so let's just turn off omnifunc support
" in ruby -- you still get keyword completion.
let g:omni_support=1
autocmd FileType ruby let g:omni_support=0

" TODO: I would like to do completeopt+=longest which has the effect of only
" completing as many characters as are unambiguous; but I can't figure out
" how to make the CleverTab function work when I do that.

" It first tries to omnicomplete (aka complete with words it knows about
" the language), and if there is no match or if we're not in a code file, it
" tries to complete with words found in the file.
let g:stop_autocomplete=0
function! CleverTab(type)
    if a:type=='omni' && g:omni_support==1
        if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
            let g:stop_autocomplete=1
            return "\<TAB>"
        elseif !pumvisible() && !&omnifunc && &omnifunc != ""
            return "\<C-X>\<C-O>\<C-P>"
        endif
    elseif a:type=='keyword' && !pumvisible() && !g:stop_autocomplete
        return "\<C-X>\<C-N>\<C-P>"
    elseif a:type=='next'
        if g:stop_autocomplete
            let g:stop_autocomplete=0
        else
            return "\<C-N>"
        endif
    endif
    return ''
endfunction
inoremap <silent><TAB> <C-R>=CleverTab('omni')<CR><C-R>=CleverTab('keyword')<CR><C-R>=CleverTab('next')<CR>

" TODO: I want to close the preview window opened by omnicomplete, but
" imapping e.g. <CR> to <esc>:pc<CR>a<CR> doesn't work when inside a code
" comment block: somehow the comment block autoformatting slides your cursor
" around when you hit escape, such that when you later hit 'a' you are in the
" wrong position.  Hopefully there exists a variable like g:autoclosepreview ?

" **************** Ctrl-L recolors the screen when it gets confused. ******
noremap <c-l> <c-l>:syntax sync fromstart<CR>
inoremap <c-l> <esc><c-l>:syntax sync fromstart<CR>a

" *************** If you type :W<cr>, save anyway. ***************
command! W w

" **************** Python config **************
" Extract method.  <leader> defaults to \
autocmd FileType python map <leader>rm :let g:bike_exceptions=1<cr>:BikeExtract<cr>

" **************** Ruby config *****************************
"use Ruby syntax highlighting on erb files
au BufReadPost *.erb set syntax=eruby 

" ***************** Tasklist settings *************
" (Shows each TODO in your file.  'q' quits, '<CR>' jumps to line.
" mnemonic: "Todo"
map T :TaskList<CR>

" ***************** NERDTree settings *************
" mnemonic: "Files"
map F :NERDTreeToggle<CR>
" Close the NERDTree after opening a file.  Because we open it with
" :NERDTreeToggle rather than :NERDTree, it will be in the same place
" the next time we need it.
let NERDTreeQuitOnOpen=1

" ************** Taglist ************
" Disable it by default because it requires Exuberant CTags.  Delete or
" comment out this line if you have Exuberant CTags installed.
let loaded_taglist = 'manually aborted'

" ************ Hidden characters ********
" Beautify display of hidden characters (tabs and line breaks)
" (:set list! to show)
set listchars=tab:▸\ ,eol:¬
" Invisible character colors - NOT working - should look like here:
" http://vimcasts.org/episodes/show-invisibles/
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" ************** Tabs ***********************
set expandtab " spaces instead of tab characters


" Nathan- and Michael-specific sections to keep peace among the nations
let whoami = "Set this to 'nathan' or 'michael'"
if whoami == "nathan"

  " Always show line numbers
  set number

  " Let the + register be the system clipboard (at least in Ubuntu?)
  set clipboard+=unnamed

  " Move lines up and down
  map <C-J> :m +1 <CR>
  map <C-K> :m -2 <CR>

  " Duplicate a selection
  " Visual mode: D
  vmap D y'>p

  " Set the leader key to comma (is normally \) for easy access to PeepOpen
  let mapleader = ","

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  " Override Michael's tab settings to be 2 spaces
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2

  " Inserts the path of the currently edited file into a command
  " Command mode: Ctrl+P
  cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

  " get jslint from http://javascriptlint.com/
  " autocmd BufWritePost *.js !test -f ~/jslint/jsl && ~/jslint/jsl -conf ~/jslint/jsl.default.conf -nologo -nosummary -process <afile>
  " What does this do? (in case i want to steal it) - M
  autocmd BufWritePost *.rb !ruby -c <afile>
  autocmd BufWritePost *.erb !erb -x -T '-' <afile> | ruby -c 


elseif whoami == "michael"
  " Any Python line over 79 chars should be highlighted
  autocmd FileType python highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
  autocmd FileType python match OverLength /\%>79v.\+/

  " On save of a Python file, strip trailing whitespaces.
  fun! <SID>StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfun
  autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()

  " Uncomment this if you like - should lint check python files upon save - N
  " (not uncommenting because I have something that checks every time I exit
  " insert mode, installed in .vim/ftplugins/python/pyflakes .) - M
  "autocmd BufWritePost *.py !python -c "compile(open('<afile>').read(), '<afile>', 'exec')"

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
    You have to set the "whoami" variable in .vimrc, to turn on nathan- or michael-specific config.  You will see this error message each time you start vim, until you do so.
endif

