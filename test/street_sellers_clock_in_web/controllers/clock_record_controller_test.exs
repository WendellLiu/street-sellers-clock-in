defmodule StreetSellersClockInWeb.ClockRecordControllerTest do
  use StreetSellersClockInWeb.ConnCase

  alias StreetSellersClockIn.ClockIn
  alias StreetSellersClockIn.ClockIn.ClockRecord

  @create_attrs %{clock_in_time: ~N[2010-04-17 14:00:00.000000], clock_out_time: ~N[2010-04-17 14:00:00.000000], latitude: 120.5, longitude: 120.5, photo_ids: "some photo_ids", planned_clock_out_time: ~N[2010-04-17 14:00:00.000000], slogan: "some slogan", status: 42}
  @update_attrs %{clock_in_time: ~N[2011-05-18 15:01:01.000000], clock_out_time: ~N[2011-05-18 15:01:01.000000], latitude: 456.7, longitude: 456.7, photo_ids: "some updated photo_ids", planned_clock_out_time: ~N[2011-05-18 15:01:01.000000], slogan: "some updated slogan", status: 43}
  @invalid_attrs %{clock_in_time: nil, clock_out_time: nil, latitude: nil, longitude: nil, photo_ids: nil, planned_clock_out_time: nil, slogan: nil, status: nil}

  def fixture(:clock_record) do
    {:ok, clock_record} = ClockIn.create_clock_record(@create_attrs)
    clock_record
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clock_records", %{conn: conn} do
      conn = get conn, clock_record_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create clock_record" do
    test "renders clock_record when data is valid", %{conn: conn} do
      conn = post conn, clock_record_path(conn, :create), clock_record: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, clock_record_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "clock_in_time" => ~N[2010-04-17 14:00:00.000000],
        "clock_out_time" => ~N[2010-04-17 14:00:00.000000],
        "latitude" => 120.5,
        "longitude" => 120.5,
        "photo_ids" => "some photo_ids",
        "planned_clock_out_time" => ~N[2010-04-17 14:00:00.000000],
        "slogan" => "some slogan",
        "status" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, clock_record_path(conn, :create), clock_record: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update clock_record" do
    setup [:create_clock_record]

    test "renders clock_record when data is valid", %{conn: conn, clock_record: %ClockRecord{id: id} = clock_record} do
      conn = put conn, clock_record_path(conn, :update, clock_record), clock_record: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, clock_record_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "clock_in_time" => ~N[2011-05-18 15:01:01.000000],
        "clock_out_time" => ~N[2011-05-18 15:01:01.000000],
        "latitude" => 456.7,
        "longitude" => 456.7,
        "photo_ids" => "some updated photo_ids",
        "planned_clock_out_time" => ~N[2011-05-18 15:01:01.000000],
        "slogan" => "some updated slogan",
        "status" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, clock_record: clock_record} do
      conn = put conn, clock_record_path(conn, :update, clock_record), clock_record: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete clock_record" do
    setup [:create_clock_record]

    test "deletes chosen clock_record", %{conn: conn, clock_record: clock_record} do
      conn = delete conn, clock_record_path(conn, :delete, clock_record)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, clock_record_path(conn, :show, clock_record)
      end
    end
  end

  defp create_clock_record(_) do
    clock_record = fixture(:clock_record)
    {:ok, clock_record: clock_record}
  end
end
