defmodule Utils.Data.String do
  def random_string(len) do
    :crypto.strong_rand_bytes(len) |> Base.url_encode64 |> binary_part(0, len)
  end
end
