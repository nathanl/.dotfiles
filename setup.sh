# Currently just a list of steps needed
# TODO - make this actually take care of everything, taking care not to
# destroy files that already exist (rename .old?)
echo 'Do the following:'
echo ''

echo 'ln -s ~/.dotfiles/zsh ~/.zsh'
echo 'ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv'
echo 'ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc'
echo ''

echo 'ln -s ~/.dotfiles/vim ~/.vim'
echo 'ln -s ~/.dotfiles/vim/vimrc ~/.vimrc'
echo 'ln -s ~/.dotfiles/vim/vimrc_simple ~/.vimrc_simple'
echo 'ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc'
echo ''

echo 'ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig'
echo 'ln -s ~/.dotfiles/git/gitignore ~/.gitignore'
echo ''

echo 'ln -s ~/.dotfiles/pryrc ~/.pryrc'
echo 'ln -s ~/.dotfiles/irbrc ~/.irbrc'
echo ''

echo 'ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf'
