To get started with NeoVim on a new machine:

  1. Install vim-plug (one-time setup):
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  2. Install plugins (whenever you add new plugins to your config):
  nvim +PlugInstall +qall
  2. Or from within NeoVim: :PlugInstall
