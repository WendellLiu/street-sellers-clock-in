defmodule StreetSellersClockIn.ClockIn.ClockRecord do
  use Ecto.Schema
  import Ecto.Changeset
  import Constants.Mapping


  schema "clock_records" do
    field :clock_in_time, :naive_datetime
    field :clock_out_time, :naive_datetime
    field :latitude, :float
    field :longitude, :float
    field :photo_ids, :string
    field :planned_clock_out_time, :naive_datetime
    field :slogan, :string
    field :status, :integer, default: clock_record_status_mapping()[:CLOCK_OUT]
    field :user_id, :id
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(clock_record, attrs) do
    clock_record
    |> cast(attrs, [:user_id,:category_id, :clock_in_time, :planned_clock_out_time, :clock_out_time, :status, :slogan, :photo_ids, :longitude, :latitude])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:category_id)
    |> validate_required([:user_id, :category_id, :clock_in_time, :planned_clock_out_time, :longitude, :latitude])
  end
end
