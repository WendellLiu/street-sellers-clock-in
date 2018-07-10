defmodule StreetSellersClockInWeb.Router do
  use StreetSellersClockInWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StreetSellersClockInWeb do
    pipe_through :api

    resources "/users", UserController, except: [:create]
  end

  scope "/api/product", StreetSellersClockInWeb do
    pipe_through :api

    resources "/categories", CategoryController
  end

  scope "/api/clock_in", StreetSellersClockInWeb do
    pipe_through :api

    resources "/clock_record", ClockRecordController do
      put "/clock_out", ClockRecordController, :clock_out, as: :clock_out
    end
  end

  scope "/api/auth", StreetSellersClockInWeb do
    pipe_through :api

    post "/signup", UserController, :create
  end
end
