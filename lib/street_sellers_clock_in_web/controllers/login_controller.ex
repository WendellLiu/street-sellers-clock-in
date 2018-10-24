defmodule StreetSellersClockInWeb.LoginController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.Accounts
  alias Utils.Auth.Password
  alias StreetSellersClockIn.Guardian

  action_fallback(StreetSellersClockInWeb.FallbackController)

  def create(conn, %{"login" => login_params}) do
    %{
      "username" => username,
      "password" => password
    } = login_params

    with user <- Accounts.get_user_by_attr!(%{username: username}) do
      case not is_nil(user) do
        true ->
          hash = Map.get(user, :password)

          case Password.check_password(password, hash) do
            true ->
              {:ok, access_token, _} =
                Guardian.encode_and_sign(user, %{permission: user.permission})

              {:ok, refresh_token, _} = Guardian.encode_and_sign(user, %{}, token_type: "refresh")

              login = %{
                access_token: access_token,
                refresh_token: refresh_token,
                user_id: user.id
              }

              conn
              |> put_status(:created)
              |> render("show.json", login: login)

            false ->
              conn
              |> put_status(:unauthorized)
              |> render(StreetSellersClockInWeb.ErrorView, :"401")
              |> halt
          end

        false ->
          conn
          |> put_status(:unauthorized)
          |> render(StreetSellersClockInWeb.ErrorView, :"401")
          |> halt
      end
    end
  end

  def create_by_invitation_code(conn, %{"login" => login_params}) do
    %{
      "invitation_code" => invitation_code
    } = login_params

    with login_invitation_code <-
           Accounts.get_active_login_invitation_code_by_attr!(%{invitation_code: invitation_code}) do
      case not is_nil(login_invitation_code) do
        true ->
          %{
            user_id: user_id
          } = login_invitation_code

          with user <- Accounts.get_user!(user_id) do
            {:ok, access_token, _} =
              Guardian.encode_and_sign(user, %{permission: user.permission})

            {:ok, refresh_token, _} = Guardian.encode_and_sign(user, %{}, token_type: "refresh")

            login = %{
              access_token: access_token,
              refresh_token: refresh_token,
              user_id: user.id
            }

            login_invitation_code_params = %{"is_active" => false}

            Accounts.update_login_invitation_code(
              login_invitation_code,
              login_invitation_code_params
            )

            conn
            |> put_status(:created)
            |> render("show.json", login: login)
          end

        false ->
          conn
          |> put_status(:unauthorized)
          |> render(StreetSellersClockInWeb.ErrorView, :"401")
          |> halt
      end
    end
  end

  def create_by_refresh_token(conn, %{"login" => login_params}) do
    %{
      "refresh_token" => given_refresh_token
    } = login_params

    {:ok, %{"sub" => user_id}} = Guardian.decode_and_verify(given_refresh_token)

    with user <- Accounts.get_user_by_attr!(%{id: user_id}) do
      case not is_nil(user) do
        true ->
          case user.is_active do
            true ->
              {:ok, access_token, _} =
                Guardian.encode_and_sign(user, %{permission: user.permission})

              {:ok, refresh_token, _} = Guardian.encode_and_sign(user, %{}, token_type: "refresh")

              login = %{
                access_token: access_token,
                refresh_token: refresh_token,
                user_id: user.id
              }

              conn
              |> put_status(:created)
              |> render("show.json", login: login)

            false ->
              conn
              |> put_status(:forbidden)
              |> render(StreetSellersClockInWeb.ErrorView, :"403")
              |> halt
          end

        false ->
          conn
          |> put_status(:unauthorized)
          |> render(StreetSellersClockInWeb.ErrorView, :"401")
          |> halt
      end
    end
  end
end
