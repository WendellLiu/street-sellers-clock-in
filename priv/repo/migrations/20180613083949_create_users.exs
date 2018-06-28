defmodule StreetSellersClockIn.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :alias, :string
      add :avatar_id, :string
      add :password, :string
      add :email, :string
      add :clock_record_id, references(:clock_records, on_delete: :nothing)
      add :memo, :string

      timestamps()
    end

    create index(:users, [:clock_record_id])
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])

  end
end
