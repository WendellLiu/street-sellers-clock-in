defmodule Utils.Data.Converters do
  def array_to_string(params, field, joiner \\ ",") do
    cond do
      Map.has_key?(params, field) ->
        Map.put(
          params,
          field,
          Map.get(params, field) |> Enum.join(joiner)
        )
      true ->
        params
    end
  end

  def safe_string_split(str, pattern \\ ",") do
    case str do
        s when not is_nil(s) -> str |> String.split(pattern)
        nil -> str
    end
  end

  def map_to_keyword_list(m) do
    Enum.map(m, fn {key, value} -> {:"#{key}", value} end)
  end
end
