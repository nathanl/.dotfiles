" `source` needs an absolute path
source $HOME/.config/nvim/general/plugins.vim
source $HOME/.config/nvim/general/colors.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/mappings.vim
source $HOME/.config/nvim/general/file_types.vim
source $HOME/.config/nvim/general/basic_tab_completion.vim
source $HOME/.config/nvim/general/abbreviations.vim
" Maybe uncomment this if I can make it work better and faster
" source $HOME/.config/nvim/general/lspconfig.vim

" If there are any machine-specific tweaks for Vim, load them from the
" following file.
try 
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry 
