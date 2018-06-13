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
      add :user_id, references(:users, on_delete: :nothing)
      add :category_id, references(:product_categories, on_delete: :nothing)

      timestamps()
    end

    create index(:clock_records, [:user_id])
    create index(:clock_records, [:category_id])
  end
end
