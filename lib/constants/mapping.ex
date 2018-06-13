defmodule Constants.Mapping do
  @clock_record_status_mapping %{
    CLOCK_OUT: 0,
    CLOCK_IN: 1,
  }

  def clock_record_status_mapping, do: @clock_record_status_mapping 
end