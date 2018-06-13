defmodule StreetSellersClockIn.Product.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "product_categories" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
