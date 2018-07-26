defmodule StreetSellersClockInWeb.LoginTokenView do
  use StreetSellersClockInWeb, :view
  alias StreetSellersClockInWeb.LoginTokenView

  def render("index.json", %{login_tokens: login_tokens}) do
    %{data: render_many(login_tokens, LoginTokenView, "login_token.json")}
  end

  def render("show.json", %{login_token: login_token}) do
    %{data: render_one(login_token, LoginTokenView, "login_token.json")}
  end

  def render("login_token.json", %{login_token: login_token}) do
    %{id: login_token.id,
      token: login_token.token,
      salt: login_token.salt,
      expired_time: login_token.expired_time}
  end
end
