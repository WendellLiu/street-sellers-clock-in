defmodule StreetSellersClockInWeb.Router do
  use StreetSellersClockInWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StreetSellersClockInWeb do
    pipe_through :api
  end

  scope "/api/auth", StreetSellersClockInWeb do
    pipe_through :api

    post "/signup", UserController, :create
  end
end
