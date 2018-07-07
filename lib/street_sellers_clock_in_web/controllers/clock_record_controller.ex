defmodule StreetSellersClockInWeb.ClockRecordController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.ClockIn
  alias StreetSellersClockIn.ClockIn.ClockRecord

  action_fallback StreetSellersClockInWeb.FallbackController

  def index(conn, _params) do
    clock_records = ClockIn.list_clock_records()
    render(conn, "index.json", clock_records: clock_records)
  end

  def create(conn, %{"clock_record" => clock_record_params}) do
    clock_record_params = clock_record_params
      |> handle_category_ids

    with {:ok, %ClockRecord{} = clock_record} <- ClockIn.create_clock_record(clock_record_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", clock_record_path(conn, :show, clock_record))
      |> render("show.json", clock_record: clock_record)
    end
  end

  def show(conn, %{"id" => id}) do
    clock_record = ClockIn.get_clock_record!(id)
    render(conn, "show.json", clock_record: clock_record)
  end

  def update(conn, %{"id" => id, "clock_record" => clock_record_params}) do
    clock_record = ClockIn.get_clock_record!(id)

    with {:ok, %ClockRecord{} = clock_record} <- ClockIn.update_clock_record(clock_record, clock_record_params) do
      render(conn, "show.json", clock_record: clock_record)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock_record = ClockIn.get_clock_record!(id)
    with {:ok, %ClockRecord{}} <- ClockIn.delete_clock_record(clock_record) do
      send_resp(conn, :no_content, "")
    end
  end

  defp handle_category_ids(clock_record_params) do
    cond do
      Map.has_key?(clock_record_params, "category_ids") ->
        Map.put(
          clock_record_params,
          "category_ids",
          Map.get(clock_record_params, "category_ids") |> Enum.join(",")
        )
      true ->
        clock_record_params
    end
  end
end
