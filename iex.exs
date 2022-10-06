# Elixir interactive shell configuration
# Symlink to ~/.iex.exs
# IEx.configure(colors: [ eval_result: [:red, :bright] ])
# IEx.configure(inspect: [limit: 10])
#
# [97, 98, 99] is inspected as a list of integers by default
IEx.configure(inspect: [charlists: :as_lists])

# TODO - to enable an alias, I could:
# - create a shell alias for iex
# - have my alias first run the elixirc command
# - have my alias start iex with the flag `-pz` and give the path of the beam file produced
# {_, 0} = System.cmd("elixirc", [Path.expand("~/.dotfiles/elixir/custom.ex"), "--ignore-module-conflict"])
# iex -pz ~/.dotfiles
# import Custom, only: [hi: 0]
