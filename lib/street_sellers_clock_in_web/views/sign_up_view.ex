defmodule StreetSellersClockInWeb.SignUpView do
  use StreetSellersClockInWeb, :view

  def render("fail.json", %{message: message}) do
    %{
      error: %{
        message: message,
      }
    }
  end

  def render("index.json", _) do
    %{data: "OK"}
  end
end
