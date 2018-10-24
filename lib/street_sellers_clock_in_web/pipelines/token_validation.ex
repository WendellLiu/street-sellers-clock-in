defmodule StreetSellersClockInWeb.Pipeline.TokenValidation do
  use Guardian.Plug.Pipeline,
    otp_app: :street_sellers_clock_in,
    error_handler: AuthMe.UserManager.ErrorHandler,
    module: StreetSellersClockIn.Guardian

  # If there is an authorization header, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
end
