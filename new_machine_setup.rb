# execute mkdir ~/.bundle

%x{mkdir ~/.bundle} unless File.exist?(File.expand_path("~/.bundle"))

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

puts "don't forget to do the stuff in ~/.dotfiles/ssh_config"
puts "use zsh: 1) brew install zsh 2) add to /etc/shells 3) chsh -s $(which zsh)"
