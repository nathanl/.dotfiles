" `source` needs an absolute path
source $HOME/.config/nvim/general/plugins.vim
source $HOME/.config/nvim/general/colors.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/mappings.vim

" If there are any machine-specific tweaks for Vim, load them from the
" following file.
try 
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry 
