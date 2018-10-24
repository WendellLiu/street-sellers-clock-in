defmodule StreetSellersClockInWeb.UserView do
  use StreetSellersClockInWeb, :view
  alias StreetSellersClockInWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      alias: user.alias,
      avatar_id: user.avatar_id,
      email: user.email,
      memo: user.memo,
      clock_record_id: user.clock_record_id,
      permission: user.permission,
      active: user.active
    }
  end
end
