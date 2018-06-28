defmodule StreetSellersClockIn.Repo.Migrations.CreateClockRecords do
  use Ecto.Migration

  def change do
    create table(:clock_records) do
      add :clock_in_time, :naive_datetime
      add :planned_clock_out_time, :naive_datetime
      add :clock_out_time, :naive_datetime
      add :status, :integer
      add :slogan, :string
      add :photo_ids, :string
      add :longitude, :float
      add :latitude, :float
      add :category_ids, :string

      timestamps()
    end

  end
end
