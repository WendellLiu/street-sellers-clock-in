defmodule StreetSellersClockInWeb.LoginController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.Accounts.LoginToken

  action_fallback StreetSellersClockInWeb.FallbackController

  def create(conn, %{"login" => login_params}) do
    with {:ok, %LoginToken{} = login} <- Accounts.create_login(login_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", login_path(conn, :show, login))
      |> render("show.json", login: login)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   login = Accounts.get_login!(id)
  #   render(conn, "show.json", login: login)
  # end
end
