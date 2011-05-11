Custom dotfiles - Vim configuration, etc - shared by me and Michael Gundlach.
Others can copy if they like.

The following files should be symlinked from home directory (taken from the
output of `ls -lah | grep .dot` in my home directory)

.bash@ -> .dotfiles/bash
.bash_profile@ -> .dotfiles/bash/bash_profile
.dotfiles/
.gitignore@ -> .dotfiles/gitignore
.gvimrc@ -> .dotfiles/.gvimrc
.irbrc@ -> .dotfiles/irbrc
.vim@ -> .dotfiles/.vim
.vimrc@ -> .dotfiles/.vimrc
.zsh@ -> .dotfiles/.zsh
.zshrc@ -> .dotfiles/.zsh/zshrc

You can create these symlinks like, for example, `ln -s .dotfiles/.vimrc .vimrc`
