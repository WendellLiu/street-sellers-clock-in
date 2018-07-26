defmodule StreetSellersClockInWeb.LoginTokenController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.Accounts.LoginToken

  action_fallback StreetSellersClockInWeb.FallbackController

  def index(conn, _params) do
    login_tokens = Accounts.list_login_tokens()
    render(conn, "index.json", login_tokens: login_tokens)
  end

  # def create(conn, %{"login_token" => login_token_params}) do
  #   with {:ok, %LoginToken{} = login_token} <- Accounts.create_login_token(login_token_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", login_token_path(conn, :show, login_token))
  #     |> render("show.json", login_token: login_token)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    login_token = Accounts.get_login_token!(id)
    render(conn, "show.json", login_token: login_token)
  end

  def update(conn, %{"id" => id, "login_token" => login_token_params}) do
    login_token = Accounts.get_login_token!(id)

    with {:ok, %LoginToken{} = login_token} <- Accounts.update_login_token(login_token, login_token_params) do
      render(conn, "show.json", login_token: login_token)
    end
  end

  def delete(conn, %{"id" => id}) do
    login_token = Accounts.get_login_token!(id)
    with {:ok, %LoginToken{}} <- Accounts.delete_login_token(login_token) do
      send_resp(conn, :no_content, "")
    end
  end
end
