defmodule StreetSellersClockIn.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Utils.Auth.Password


  schema "users" do
    field :alias, :string
    field :avatar_id, :string
    field :email, :string
    field :password, :string
    field :username, :string
    field :memo, :string
    field :clock_record_id, :id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :alias, :avatar_id, :password, :email, :memo, :clock_record_id])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> foreign_key_constraint(:clock_record_id)
    |> validate_required([:username, :alias, :password])
    |> handle_password
  end

  defp handle_password(profile) do
    cond do
      Map.has_key?(profile, "password") -> put_change(profile, :password, Password.hash_password(get_field(profile, :password)))
      true -> profile
    end
  end
end
