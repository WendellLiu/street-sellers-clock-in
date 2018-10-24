defmodule StreetSellersClockIn.Repo.Migrations.AddActiveInUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:active, :boolean, default: true)
    end
  end
end
