defmodule StreetSellersClockInWeb.LoginInvitationCodeController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.Accounts.LoginInvitationCode
  import Utils.Data.String

  action_fallback StreetSellersClockInWeb.FallbackController

  def index(conn, _params) do
    login_invitation_code = Accounts.list_login_invitation_code()
    render(conn, "index.json", login_invitation_code: login_invitation_code)
  end

  def create(conn, %{"login_invitation_code" => login_invitation_code_params}) do
    invitation_code_length = Application.get_env(:street_sellers_clock_in, StreetSellersClockInWeb.Endpoint)[:invitation_code_length]
    login_invitation_code_params = login_invitation_code_params
      |> Map.put(
          "invitation_code",
          random_number_string(invitation_code_length)
        )
    IO.inspect login_invitation_code_params
    with {:ok, %LoginInvitationCode{} = login_invitation_code} <- Accounts.create_login_invitation_code(login_invitation_code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", login_invitation_code_path(conn, :show, login_invitation_code))
      |> render("show.json", login_invitation_code: login_invitation_code)
    end
  end

  def show(conn, %{"id" => id}) do
    login_invitation_code = Accounts.get_login_invitation_code!(id)
    render(conn, "show.json", login_invitation_code: login_invitation_code)
  end

  def update(conn, %{"id" => id, "login_invitation_code" => login_invitation_code_params}) do
    login_invitation_code = Accounts.get_login_invitation_code!(id)

    with {:ok, %LoginInvitationCode{} = login_invitation_code} <- Accounts.update_login_invitation_code(login_invitation_code, login_invitation_code_params) do
      render(conn, "show.json", login_invitation_code: login_invitation_code)
    end
  end

  def delete(conn, %{"id" => id}) do
    login_invitation_code = Accounts.get_login_invitation_code!(id)
    with {:ok, %LoginInvitationCode{}} <- Accounts.delete_login_invitation_code(login_invitation_code) do
      send_resp(conn, :no_content, "")
    end
  end
end
