set guioptions-=T " hide toolbar
set guitablabel=%N:%M%t " Show tab numbers - `Ngt` goes to tab N
set lines=68 columns=128

set background=dark
colorscheme solarized

set guifont=DejaVu\ Sans\ Mono:h13

" If there are any machine-specific tweaks for GUI Vim, load them from the following file.
try 
  source .gvimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry 
