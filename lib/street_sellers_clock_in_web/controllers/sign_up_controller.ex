defmodule StreetSellersClockInWeb.UserController do
  use StreetSellersClockInWeb, :controller

  def create(conn, %{"username" => _, "password" => _}) do
    render(conn, "index.json")
  end
end