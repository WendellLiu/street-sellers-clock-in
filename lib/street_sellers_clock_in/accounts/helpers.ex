defmodule StreetSellersClockIn.Accounts.Helpers do
  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.ClockIn
  alias Utils.Auth.LoginToken

  def clock_out_expired_record do
    Accounts.get_expired_users()
      |> Enum.map(&(&1["clock_record_id"]))
      |> Enum.map(fn(clock_record_id) -> ClockIn.clock_out(clock_record_id) end)
  end

  defp login_token_to_map(%StreetSellersClockIn.Accounts.LoginToken{
    expired_time: expired_time,
    id: id,
    token: token,
    user_id: user_id,
  }) do
    %{
      expired_time: expired_time,
      id: id,
      token: token,
      user_id: user_id,
    }
  end

  def cache_active_token do
    Accounts.get_active_login_token!
      |> Enum.map(fn n -> login_token_to_map(n) end)
      |> Enum.map(
          fn login_token ->
            LoginToken.cache_one_token(login_token.token, login_token) end
        )
  end
end
