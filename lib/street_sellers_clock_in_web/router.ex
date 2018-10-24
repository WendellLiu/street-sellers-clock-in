defmodule StreetSellersClockInWeb.Router do
  use StreetSellersClockInWeb, :router
  alias StreetSellersClockInWeb.Pipeline.TokenValidation

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :protected_api do
    plug(:accepts, ["json"])
    plug(TokenValidation)
  end

  scope "/api", StreetSellersClockInWeb do
    pipe_through(:api)

    resources("/users", UserController, only: [:index, :show])
  end

  scope "/api", StreetSellersClockInWeb do
    pipe_through(:protected_api)

    resources("/login_invitation_code", LoginInvitationCodeController)
  end

  scope "/api/product", StreetSellersClockInWeb do
    pipe_through(:protected_api)

    resources("/categories", CategoryController, except: [:index, :show])
  end

  scope "/api/product", StreetSellersClockInWeb do
    pipe_through(:api)

    resources("/categories", CategoryController, only: [:index, :show])
  end

  # for street sellers
  scope "/api", StreetSellersClockInWeb do
    pipe_through(:protected_api)

    resources("/clock_record", ClockRecordController, only: [:index, :show, :update])
    post("/clock_record/clock_in", ClockRecordController, :create, as: :street_seller_clock_in)

    put("/clock_record/clock_out", ClockRecordController, :clock_out, as: :street_seller_clock_out)
  end

  scope "/api/auth", StreetSellersClockInWeb do
    pipe_through(:api)

    post("/signup", UserController, :create)
    post("/login", LoginController, :create)
    post("/login/invitation_code", LoginController, :create_by_invitation_code)
    post("/login/refresh_token", LoginController, :create_by_refresh_token)
  end
end
