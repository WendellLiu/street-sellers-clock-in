defmodule StreetSellersClockInWeb.Router do
  use StreetSellersClockInWeb, :router
  alias StreetSellersClockInWeb.Pipelines.TokenValidation
  alias StreetSellersClockInWeb.Pipelines.PermissionCheck
  alias Constants.Mapping

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :seller_protected_api do
    plug(:accepts, ["json"])
    plug(TokenValidation)
    plug(PermissionCheck, Mapping.user_permission()[:SELLER])
  end

  pipeline :operation_protected_api do
    plug(:accepts, ["json"])
    plug(TokenValidation)
    plug(PermissionCheck, Mapping.user_permission()[:OPERATION])
  end

  pipeline :admin_protected_api do
    plug(:accepts, ["json"])
    plug(TokenValidation)
    plug(PermissionCheck, Mapping.user_permission()[:ADMIN])
  end

  scope "/api", StreetSellersClockInWeb do
    pipe_through(:api)

    resources("/users", UserController, only: [:index, :show])
  end

  # TODO: add change user data api routes
  scope "/api", StreetSellersClockInWeb do
    pipe_through(:admin_protected_api)

    resources("/users", UserController, only: [:update, :delete])
  end

  scope "/api", StreetSellersClockInWeb do
    pipe_through(:operation_protected_api)

    resources("/login_invitation_code", LoginInvitationCodeController)
  end

  scope "/api/product", StreetSellersClockInWeb do
    pipe_through(:operation_protected_api)

    resources("/categories", CategoryController, except: [:index, :show])
  end

  scope "/api/product", StreetSellersClockInWeb do
    pipe_through(:api)

    resources("/categories", CategoryController, only: [:index, :show])
  end

  # for street sellers
  scope "/api", StreetSellersClockInWeb do
    pipe_through(:seller_protected_api)

    put("/clock_record/clock_out", ClockRecordController, :street_seller_clock_out)

    post("/clock_record/clock_in", ClockRecordController, :create, as: :street_seller_clock_in)
    resources("/clock_record", ClockRecordController, only: [:index, :show, :update])
  end

  scope "/api/auth", StreetSellersClockInWeb do
    pipe_through(:api)

    post("/signup", UserController, :create)
    post("/login", LoginController, :create)
    post("/login/invitation_code", LoginController, :create_by_invitation_code)
    post("/login/refresh_token", LoginController, :create_by_refresh_token)
  end
end
