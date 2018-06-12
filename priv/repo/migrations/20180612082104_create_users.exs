defmodule StreetSellersClockIn.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :alias, :string
      add :avatar_id, :string
      add :password, :string
      add :email, :string

      timestamps()
    end

  end
end
