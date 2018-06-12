defmodule StreetSellersClockInWeb.UserView do
  use StreetSellersClockInWeb, :view
  alias StreetSellersClockInWeb.UserView

  def render("fail.json", %{message: message}) do
    %{
      error: %{
        message: message,
      }
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      # id: user.id,
      email: user.email,
      username: user.username,
      password: user.password,
      alias: user.alias,
      avatar_id: user.avatarId,
    }
  end
end
