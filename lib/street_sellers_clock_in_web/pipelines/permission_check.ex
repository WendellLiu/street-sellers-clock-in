defmodule StreetSellersClockInWeb.Pipelines.PermissionCheck do
  alias Plug.Conn

  def init(require_permission_level), do: require_permission_level

  def call(conn, require_permission_level) do
    %{
      "permission" => user_permission
    } = Guardian.Plug.current_claims(conn)

    case user_permission <= require_permission_level do
      true ->
        conn

      false ->
        conn
        |> Conn.put_status(:forbidden)
        |> Phoenix.Controller.render(StreetSellersClockInWeb.ErrorView, :"403")
        |> Conn.halt()
    end
  end
end
