# To be used in iex
defmodule Custom do
  def codepoint_to_string(cp) when is_integer(cp) when cp >= 0 and cp <= 2_097_151 do
    <<cp :: utf8>>
  end
  def codepoint_to_string(cp) when is_binary(cp) do
    :erlang.binary_to_integer(cp, 16) |> codepoint_to_string
  end
end

