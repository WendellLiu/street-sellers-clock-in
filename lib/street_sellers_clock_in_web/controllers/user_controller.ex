defmodule StreetSellersClockInWeb.UserController do
  use StreetSellersClockInWeb, :controller

  def create(conn, %{
    "username" => username, 
    "password" => password, 
    "alias" => alias_,
    "email" => email,
  }) do
    user = %{
      username: username, 
      password: password, 
      alias: alias_,
      email: email,
      avatarId: 1,
    }
    render(conn, "show.json", user: user)
  end
end