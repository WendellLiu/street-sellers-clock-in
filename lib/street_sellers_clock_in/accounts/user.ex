defmodule StreetSellersClockIn.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :alias, :string
    field :avatar_id, :string
    field :email, :string
    field :password, :string
    field :username, :string
    field :memo, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :alias, :avatar_id, :password, :email, :memo])
    |> validate_required([:username, :alias, :password])
  end
end
