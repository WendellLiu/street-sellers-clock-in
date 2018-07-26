defmodule StreetSellersClockInWeb.LoginController do
  use StreetSellersClockInWeb, :controller

  import Ecto.Changeset
  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.Accounts.LoginToken
  alias Utils.Auth.Password
  alias Utils.Auth.LoginToken

  action_fallback StreetSellersClockInWeb.FallbackController

  def create(conn, %{"login" => login_params}) do
    %{
      "username"=> username,
      "password"=> password,
    } = login_params

    with user when not is_nil(user) <- Accounts.get_user_by_attr!(%{username: username}) do
      # FIXME: bug
      hash = get_field(user, :password)
      IO.puts(hash)

    end
    # with {:ok, %LoginToken{} = login} <- Accounts.create_login(login_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", login_path(conn, :show, login))
    #   |> render("show.json", login: login)
    # end
  end

  # def show(conn, %{"id" => id}) do
  #   login = Accounts.get_login!(id)
  #   render(conn, "show.json", login: login)
  # end
end
