defmodule Utils.Redis do
  import Redix

  @host Application.get_env(:redix, :host)
  @port String.to_integer(Application.get_env(:redix, :port))

  defp get_conn do
    {:ok, conn} = start_link(host: @host, port: @port)
    conn
  end

  defp handel_get_return({:ok, nil}) do
    {:ok, nil}
  end

  defp handel_get_return({:ok, value}) do
    {:ok, Poison.decode!(value)}
  end

  defp handel_get_return({:error, value}) do
    {:error, value}
  end

  def get(key) do
    get_conn()
      |> command(["GET", key])
      |> handel_get_return
  end

  def set(key, value) do
    conn = get_conn()
    command(conn, ["SET", key, Poison.encode!(value)])
  end

  def set_and_get(key, value) do
    conn = get_conn()
    case pipeline!(conn, [["SET", key, Poison.encode!(value)], ["GET", key]]) do
      ["OK", v] -> {:ok, v}
      _ -> {:error}
    end
  end

  def get_keys(pattern \\ "*") do
    conn = get_conn()
    command(conn, ["KEYS", pattern])
  end

  # keys :: Array<key>
  def del(keys) do
    conn = get_conn()
    command(conn, Enum.concat(["DEL"], keys))
  end
end
