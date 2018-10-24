defmodule Constants.Mapping do
  @clock_record_status_mapping %{
    CLOCK_OUT: 0,
    CLOCK_IN: 1
  }

  @user_permission %{
    ADMIN: 0,
    OPERATION: 3,
    SELLER: 10
  }

  def clock_record_status_mapping, do: @clock_record_status_mapping
  def user_permission, do: @user_permission
end
