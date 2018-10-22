defmodule StreetSellersClockInWeb.LoginController do
  use StreetSellersClockInWeb, :controller

  # TODO: remove token util
  alias StreetSellersClockIn.Accounts.LoginToken
  alias Utils.Auth.LoginToken, as: LoginTokenUtils

  alias StreetSellersClockIn.Accounts
  alias Utils.Auth.Password
  alias StreetSellersClockIn.Guardian

  action_fallback StreetSellersClockInWeb.FallbackController

  def create(conn, %{"login" => login_params}) do
    %{
      "username" => username,
      "password" => password,
    } = login_params

    with user <- Accounts.get_user_by_attr!(%{username: username}) do
      case not is_nil(user) do
        true ->
          hash = Map.get(user, :password)

          case Password.check_password(password, hash) do
            true ->
              {:ok, token, claims}  = Guardian.encode_and_sign(user, %{permission: user.permission})

              login = %{
                token: token,
                user_id: user.id,
              }

              conn
              |> put_status(:created)
              |> render("show.json", login: login)
            false -> conn
              |> put_status(:unauthorized)
              |> render(StreetSellersClockInWeb.ErrorView, :"401")
              |> halt
          end
        false -> conn
          |> put_status(:unauthorized)
          |> render(StreetSellersClockInWeb.ErrorView, :"401")
          |> halt
      end
    end
  end

  def create_by_token(conn, %{"login" => login_params}) do
    %{
      "token" => token,
    } = login_params

    case LoginTokenUtils.get_info_from_cache(token) do
      {:ok, login_token} when not is_nil(login_token) ->
        login_token = %{
          token: login_token["token"],
          expired_time: login_token["expired_time"],
          user_id: login_token["user_id"],
        }
        conn
        |> put_status(:ok)
        |> render("show.json", login_token: login_token)
      {:ok, nil} ->
        conn
        |> put_status(:unauthorized)
        |> render(StreetSellersClockInWeb.ErrorView, :"401")
        |> halt
      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> render(StreetSellersClockInWeb.ErrorView, :"401")
        |> halt
    end
  end

  def create_by_invitation_code(conn, %{"login" => login_params}) do
    %{
      "invitation_code" => invitation_code,
    } = login_params

    with login_invitation_code <-
      Accounts.get_active_login_invitation_code_by_attr!(%{invitation_code: invitation_code}) do
      case not is_nil(login_invitation_code) do
        true ->
          %{
            token: token,
          } = LoginTokenUtils.gen_token()

          login_token_params = %{
            token: token,
            user_id: login_invitation_code.user_id,
          }

          login_invitation_code_params = %{"is_active"=> false}
          Accounts.update_login_invitation_code(login_invitation_code, login_invitation_code_params)

          with {:ok, %LoginToken{} = login_token} <- Accounts.create_login_token(login_token_params) do
            token_info = %{
              token: login_token.token,
              user_id: login_token.user_id,
              expired_time: login_token.expired_time,
            }
            LoginTokenUtils.cache_one_token(login_token.token, token_info)
            conn
            |> put_status(:created)
            |> render("show.json", login_token: login_token)
          end

        false ->conn
          |> put_status(:unauthorized)
          |> render(StreetSellersClockInWeb.ErrorView, :"401")
          |> halt
      end
    end
  end
end
