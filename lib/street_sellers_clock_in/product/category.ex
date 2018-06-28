defmodule StreetSellersClockIn.Product.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "product_categories" do
    field :name, :string
    field :memo, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :memo])
    |> validate_required([:name])
  end
end
