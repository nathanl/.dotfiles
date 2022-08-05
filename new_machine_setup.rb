# execute mkdir ~/.bundle

%x{mkdir ~/.bundle} unless File.exist?(File.expand_path("~/.bundle"))

# For the neovim config to go in
%x{mkdir ~/.config}

FILES = {
  "zsh"                   => ".zsh",
  "zsh/zshrc"             => ".zshrc",
  "zsh/zshenv"            => ".zshenv",

  "tmux.conf"             => ".tmux.conf",

  "vim"                   => ".vim",
  "vim/vimrc"             => ".vimrc",
  "vim/vimrc_simple"      => ".vimrc_simple",
  "vim/vimrc_barebones"   => ".vimrc_barebones",
  "vim/gvimrc"            => ".gvimrc",

  "neovim"                => ".config/nvim",

  "git/gitconfig"         => ".gitconfig",
  "git/gitignore"         => ".gitignore",

  "psqlrc"                => ".psqlrc",

  "irbrc"                 => ".irbrc",
  "pryrc"                 => ".pryrc",
  "bundle_config"         => ".bundle/config",
  "iex.exs"               => ".iex.exs",
}

FILES.each do |original_file, symlink_location|
  source = File.expand_path("~/.dotfiles/#{original_file}")
  dest   = File.expand_path("~/#{symlink_location}")
  if File.exist?(dest)
    puts "exists: #{dest}"
  else
    result = system("ln -s #{source} #{dest}")
    puts "symlinking #{source} -> #{dest} #{result ? "worked" : "failed"}"
  end
end

# Install Git submodules (vim plugins)
system("cd ~/.dotfiles && git submodules-please")

# Install asdf version manager
system("git clone https://github.com/asdf-vm/asdf.git ~/.asdf")
system("cd ~/.asdf && git checkout \"$(git describe --abbrev=0 --tags)\"")

puts """
Other stuff to install:
- homebrew
- brew install neovim (and go run PlugInstall! in the plugins file)
- brew install reattach-to-user-namespace (for tmux)
- brew install tmux
- brew install diffr (for git diffs)
- brew install ripgrep
- brew install git (if you want the latest)
- maybe do the stuff in ~/.dotfiles/ssh_config
"""
