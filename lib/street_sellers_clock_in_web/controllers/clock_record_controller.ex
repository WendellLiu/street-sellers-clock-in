defmodule StreetSellersClockInWeb.ClockRecordController do
  use StreetSellersClockInWeb, :controller

  alias StreetSellersClockIn.ClockIn
  alias StreetSellersClockIn.ClockIn.ClockRecord
  alias StreetSellersClockIn.Accounts
  alias Utils.Data.Converters

  action_fallback(StreetSellersClockInWeb.FallbackController)

  def index(conn, _params) do
    clock_records = ClockIn.list_clock_records()
    render(conn, "index.json", clock_records: clock_records)
  end

  def create(conn, %{
        "clock_record" => clock_record_params
      }) do
    %{
      "sub" => user_id
    } = Guardian.Plug.current_claims(conn)

    user = Accounts.get_user!(user_id)

    case user.clock_record_id do
      nil ->
        clock_record_params = clock_record_params |> Converters.array_to_string("category_ids")

        with {:ok, %ClockRecord{} = clock_record} <-
               ClockIn.create_clock_record(clock_record_params) do
          user_params = %{
            clock_record_id: clock_record |> Map.get(:id)
          }

          with {:ok, _} <- Accounts.update_user(user, user_params) do
            conn
            |> put_status(:created)
            |> put_resp_header("location", clock_record_path(conn, :show, clock_record))
            |> render("show.json", clock_record: clock_record)
          end
        end

      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(StreetSellersClockInWeb.ErrorView, :"422")
        |> halt
    end
  end

  def show(conn, %{"id" => id}) do
    clock_record = ClockIn.get_clock_record!(id)
    render(conn, "show.json", clock_record: clock_record)
  end

  def update(conn, %{"id" => id, "clock_record" => clock_record_params}) do
    clock_record = ClockIn.get_clock_record!(id)

    with {:ok, %ClockRecord{} = clock_record} <-
           ClockIn.update_clock_record(clock_record, clock_record_params) do
      render(conn, "show.json", clock_record: clock_record)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock_record = ClockIn.get_clock_record!(id)

    with {:ok, %ClockRecord{}} <- ClockIn.delete_clock_record(clock_record) do
      send_resp(conn, :no_content, "")
    end
  end

  def clock_out(conn, %{"clock_record_id" => clock_record_id}) do
    with {:ok, %ClockRecord{} = clock_record} <- ClockIn.clock_out(clock_record_id) do
      render(conn, "show.json", clock_record: clock_record)
    end
  end

  def street_seller_clock_out(conn, _params) do
    %{
      "sub" => user_id
    } = Guardian.Plug.current_claims(conn)

    user = Accounts.get_user!(user_id)

    with %{
           clock_record_id: clock_record_id
         } <- user do
      case is_nil(clock_record_id) do
        true ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(StreetSellersClockInWeb.ErrorView, :"422")
          |> halt

        _ ->
          with {:ok, %ClockRecord{} = clock_record} <- ClockIn.clock_out(clock_record_id) do
            render(conn, "show.json", clock_record: clock_record)
          end
      end
    end
  end
end
