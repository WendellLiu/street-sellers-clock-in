defmodule StreetSellersClockInWeb.LoginView do
  use StreetSellersClockInWeb, :view
  alias StreetSellersClockInWeb.LoginTokenView
  alias StreetSellersClockInWeb.LoginView

  def render("index.json", %{login_tokens: login_tokens}) do
    %{data: render_many(login_tokens, LoginTokenView, "login_token.json")}
  end

  def render("show.json", %{login: login}) do
    %{data: render_one(login, LoginView, "login.json")}
  end

  def render("login.json", %{
    login: login,
  }) do
    %{
      token: login.token,
      # expired_time: login.expired_time,
      user_id: login.user_id,
    }
  end
end
