defmodule StreetSellersClockInWeb.Pipelines.TokenValidation do
  use Guardian.Plug.Pipeline,
    otp_app: :street_sellers_clock_in,
    error_handler: StreetSellersClockInWeb.Pipelines.TokenValidationErrorHandler,
    module: StreetSellersClockIn.Guardian

  # If there is an authorization header, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated, claims: %{"typ" => "access"})
end
