defmodule StreetSellersClockInWeb.Router do
  use StreetSellersClockInWeb, :router
  import StreetSellersClockInWeb.Plugs

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected_api do
    plug :accepts, ["json"]
    plug :token_auth
  end

  scope "/api", StreetSellersClockInWeb do
    pipe_through :protected_api

    resources "/users", UserController, except: [:create] do
      post "/clock_in", ClockRecordController, :create, as: :user_clock_in
    end

    resources "/login_invitation_code", LoginInvitationCodeController
  end

  scope "/api/product", StreetSellersClockInWeb do
    pipe_through :protected_api

    resources "/categories", CategoryController
  end

  scope "/api/clock_in", StreetSellersClockInWeb do
    pipe_through :protected_api

    resources "/clock_record", ClockRecordController, except: [:create] do
      put "/clock_out", ClockRecordController, :clock_out, as: :clock_out
    end
  end

  scope "/api/auth", StreetSellersClockInWeb do
    pipe_through :api

    post "/signup", UserController, :create
    post "/login", LoginController, :create
    post "/login/token", LoginController, :create_by_token
    post "/login/invitation_code", LoginController, :create_by_invitation_code
  end
end
