defmodule StreetSellersClockIn.Accounts.Helpers do
  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.ClockIn

  def clock_out_expired_record do
    Accounts.get_expired_users()
      |> Enum.map(&(&1["clock_record_id"]))
      |> Enum.map(fn(clock_record_id) -> ClockIn.clock_out(clock_record_id) end)
  end
end
