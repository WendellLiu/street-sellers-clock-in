defmodule Utils.Data.String do
  def random_string(len) do
    :crypto.strong_rand_bytes(len) |> Base.url_encode64 |> binary_part(0, len)
  end

  def random_number_string(len) do
    l = for _ <- 1..len, do: Enum.random(1..9) |> to_string
    l |> Enum.join
  end
end
