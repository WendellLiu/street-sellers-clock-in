defmodule StreetSellersClockIn.Repo.Migrations.AddMemoInUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :memo, :string
    end
  end
end
