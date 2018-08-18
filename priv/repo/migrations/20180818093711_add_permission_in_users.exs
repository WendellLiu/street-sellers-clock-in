defmodule StreetSellersClockIn.Repo.Migrations.AddPermissionInUsers do
  use Ecto.Migration
  import Constants.Mapping

  def change do
    alter table(:users) do
      add :permission, :integer, default: user_permission()[:SELLER]
    end
  end
end
