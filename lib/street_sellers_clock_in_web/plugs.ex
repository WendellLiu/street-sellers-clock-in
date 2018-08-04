defmodule StreetSellersClockInWeb.Plugs do
  import Utils.Auth.LoginToken

  def token_auth(conn, _) do
    %Plug.Conn{
      req_headers: req_headers,
    } = conn

    token_info = req_headers
      |> Enum.find(fn {key, _} -> key == "authorization" end)

    case token_info do
      nil -> error_conn(conn)
      _ ->
        token_info = token_info
        |> elem(1)
        |> get_info_from_cache

        case token_info do
          {:ok, nil} -> error_conn(conn)
          {:ok, info} ->
            now = NaiveDateTime.utc_now
            expired_time = info["expired_time"]
            cond do
              expired_time == nil -> conn
              (expired_time |> NaiveDateTime.from_iso8601) >= now -> conn
              true -> error_conn(conn)
            end
        end
    end
  end

  defp error_conn(conn) do
    conn
      |> Plug.Conn.put_status(:unauthorized)
      |> Phoenix.Controller.render(StreetSellersClockInWeb.ErrorView, :"401")
      |> Plug.Conn.halt
  end
end
