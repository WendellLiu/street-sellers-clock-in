defmodule StreetSellersClockInWeb.LoginInvitationCodeView do
  use StreetSellersClockInWeb, :view
  alias StreetSellersClockInWeb.LoginInvitationCodeView

  def render("index.json", %{login_invitation_code: login_invitation_code}) do
    %{data: render_many(login_invitation_code, LoginInvitationCodeView, "login_invitation_code.json")}
  end

  def render("show.json", %{login_invitation_code: login_invitation_code}) do
    %{data: render_one(login_invitation_code, LoginInvitationCodeView, "login_invitation_code.json")}
  end

  def render("login_invitation_code.json", %{login_invitation_code: login_invitation_code}) do
    %{id: login_invitation_code.id,
      invitation_code: login_invitation_code.invitation_code,
      expired_time: login_invitation_code.expired_time,
      user_id: login_invitation_code.user_id,
      is_active: login_invitation_code.is_active,
    }
  end
end
