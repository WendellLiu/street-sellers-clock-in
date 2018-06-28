defmodule StreetSellersClockIn.Repo.Migrations.CreateProductCategories do
  use Ecto.Migration

  def change do
    create table(:product_categories) do
      add :name, :string
      add :memo, :string

      timestamps()
    end

  end
end
