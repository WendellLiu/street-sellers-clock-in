defmodule StreetSellersClockInWeb.ClockRecordView do
  use StreetSellersClockInWeb, :view
  alias StreetSellersClockInWeb.ClockRecordView

  def render("index.json", %{clock_records: clock_records}) do
    %{data: render_many(clock_records, ClockRecordView, "clock_record.json")}
  end

  def render("show.json", %{clock_record: clock_record}) do
    %{data: render_one(clock_record, ClockRecordView, "clock_record.json")}
  end

  def render("clock_record.json", %{clock_record: clock_record}) do
    %{id: clock_record.id,
      clock_in_time: clock_record.clock_in_time,
      planned_clock_out_time: clock_record.planned_clock_out_time,
      clock_out_time: clock_record.clock_out_time,
      status: clock_record.status,
      slogan: clock_record.slogan,
      photo_ids: clock_record.photo_ids,
      longitude: clock_record.longitude,
      latitude: clock_record.latitude}
  end
end
