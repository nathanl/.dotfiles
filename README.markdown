# Dotfiles, Ho!

Custom configuration files. Contains config for zsh and other files, but most of the attention has gone into the Vim config. The rest was copied from elsewhere and needs some attention.

# Setup

1. Clone this repo to ~/.vim
2.  The following files (or whatever subset you like) should be symlinked from your home directory (taken from the output of `ls -lah | grep .dot` in my home directory)

```bash
.bash@ -> .dotfiles/bash
.bash_profile@ -> .dotfiles/bash/bash_profile
.gitignore@ -> .dotfiles/gitignore
.gvimrc@ -> .dotfiles/.gvimrc
.irbrc@ -> .dotfiles/irbrc
.vim@ -> .dotfiles/.vim
.vimrc@ -> .dotfiles/.vimrc
.zsh@ -> .dotfiles/.zsh
.zshrc@ -> .dotfiles/.zsh/zshrc
```

You can create these symlinks like, for example, `ln -s .dotfiles/.vimrc .vimrc`

(TODO: create a bash (or ruby) script to set up each of these with prompt, backing up your current one)

## The One Quirk

The .vimrc in this repo was originally a collaboration between Nathan and Michael. You get Nathan's settings by default. To get Michaels's settings, create `~/.currentVimUser.vim` containing `let whoami='michael'`.
