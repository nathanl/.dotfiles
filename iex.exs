# Elixir interactive shell configuration
# Symlink to ~/.iex.exs
IEx.configure(colors: [ eval_result: [:red, :bright] ])
IEx.configure(inspect: [limit: 10])

import_file "~/.dotfiles/elixir/custom.exs"
