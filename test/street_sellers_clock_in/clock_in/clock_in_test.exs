defmodule StreetSellersClockIn.ClockInTest do
  use StreetSellersClockIn.DataCase

  alias StreetSellersClockIn.ClockIn

  describe "clock_records" do
    alias StreetSellersClockIn.ClockIn.ClockRecord

    @valid_attrs %{clock_in_time: ~N[2010-04-17 14:00:00.000000], clock_out_time: ~N[2010-04-17 14:00:00.000000], latitude: 120.5, longitude: 120.5, photo_ids: "some photo_ids", planned_clock_out_time: ~N[2010-04-17 14:00:00.000000], slogan: "some slogan", status: 42}
    @update_attrs %{clock_in_time: ~N[2011-05-18 15:01:01.000000], clock_out_time: ~N[2011-05-18 15:01:01.000000], latitude: 456.7, longitude: 456.7, photo_ids: "some updated photo_ids", planned_clock_out_time: ~N[2011-05-18 15:01:01.000000], slogan: "some updated slogan", status: 43}
    @invalid_attrs %{clock_in_time: nil, clock_out_time: nil, latitude: nil, longitude: nil, photo_ids: nil, planned_clock_out_time: nil, slogan: nil, status: nil}

    def clock_record_fixture(attrs \\ %{}) do
      {:ok, clock_record} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ClockIn.create_clock_record()

      clock_record
    end

    test "list_clock_records/0 returns all clock_records" do
      clock_record = clock_record_fixture()
      assert ClockIn.list_clock_records() == [clock_record]
    end

    test "get_clock_record!/1 returns the clock_record with given id" do
      clock_record = clock_record_fixture()
      assert ClockIn.get_clock_record!(clock_record.id) == clock_record
    end

    test "create_clock_record/1 with valid data creates a clock_record" do
      assert {:ok, %ClockRecord{} = clock_record} = ClockIn.create_clock_record(@valid_attrs)
      assert clock_record.clock_in_time == ~N[2010-04-17 14:00:00.000000]
      assert clock_record.clock_out_time == ~N[2010-04-17 14:00:00.000000]
      assert clock_record.latitude == 120.5
      assert clock_record.longitude == 120.5
      assert clock_record.photo_ids == "some photo_ids"
      assert clock_record.planned_clock_out_time == ~N[2010-04-17 14:00:00.000000]
      assert clock_record.slogan == "some slogan"
      assert clock_record.status == 42
    end

    test "create_clock_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ClockIn.create_clock_record(@invalid_attrs)
    end

    test "update_clock_record/2 with valid data updates the clock_record" do
      clock_record = clock_record_fixture()
      assert {:ok, clock_record} = ClockIn.update_clock_record(clock_record, @update_attrs)
      assert %ClockRecord{} = clock_record
      assert clock_record.clock_in_time == ~N[2011-05-18 15:01:01.000000]
      assert clock_record.clock_out_time == ~N[2011-05-18 15:01:01.000000]
      assert clock_record.latitude == 456.7
      assert clock_record.longitude == 456.7
      assert clock_record.photo_ids == "some updated photo_ids"
      assert clock_record.planned_clock_out_time == ~N[2011-05-18 15:01:01.000000]
      assert clock_record.slogan == "some updated slogan"
      assert clock_record.status == 43
    end

    test "update_clock_record/2 with invalid data returns error changeset" do
      clock_record = clock_record_fixture()
      assert {:error, %Ecto.Changeset{}} = ClockIn.update_clock_record(clock_record, @invalid_attrs)
      assert clock_record == ClockIn.get_clock_record!(clock_record.id)
    end

    test "delete_clock_record/1 deletes the clock_record" do
      clock_record = clock_record_fixture()
      assert {:ok, %ClockRecord{}} = ClockIn.delete_clock_record(clock_record)
      assert_raise Ecto.NoResultsError, fn -> ClockIn.get_clock_record!(clock_record.id) end
    end

    test "change_clock_record/1 returns a clock_record changeset" do
      clock_record = clock_record_fixture()
      assert %Ecto.Changeset{} = ClockIn.change_clock_record(clock_record)
    end
  end
end
