defmodule StreetSellersClockInWeb.LoginController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.Accounts.LoginToken
  alias Utils.Auth.Password
  alias Utils.Auth.LoginToken, as: LokginTokenUtils

  action_fallback StreetSellersClockInWeb.FallbackController

  def create(conn, %{"login" => login_params}) do
    %{
      "username"=> username,
      "password"=> password,
    } = login_params

    with user when not is_nil(user) <- Accounts.get_user_by_attr!(%{username: username}) do
      hash = Map.get(user, :password)

      case Password.check_password(password, hash) do
        true ->
          %{
            token: token,
          } = LokginTokenUtils.gen_token()

          login_token_params = %{
            token: token,
            user_id: user.id,
          }
          with {:ok, %LoginToken{} = login_token} <- Accounts.create_login_token(login_token_params) do
            token_info = %{
              token: login_token.token,
              user_id: login_token.user_id,
              expired_time: login_token.expired_time,
            }
            LokginTokenUtils.cache_one_token(login_token.token, token_info)
            conn
            |> put_status(:created)
            |> render("show.json", login_token: login_token)
          end
        false -> conn
          |> put_status(:unauthorized)
          |> render(StreetSellersClockInWeb.ErrorView, :"401")
          |> halt
      end
    end
  end

  # def show(conn, %{"id" => id}) do
  #   login = Accounts.get_login!(id)
  #   render(conn, "show.json", login: login)
  # end
end
