defmodule StreetSellersClockIn.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Utils.Auth.Password

  schema "users" do
    field(:alias, :string)
    field(:avatar_id, :string)
    field(:email, :string)
    field(:password, :string)
    field(:username, :string)
    field(:memo, :string)
    field(:clock_record_id, :id)
    field(:permission, :integer)
    field(:active, :boolean)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :alias,
      :avatar_id,
      :password,
      :email,
      :memo,
      :clock_record_id,
      :permission,
      :active
    ])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> foreign_key_constraint(:clock_record_id)
    |> validate_required([:username, :alias, :password, :permission])
    |> handle_password(attrs)
  end

  defp handle_password(profile, attrs) do
    case Map.has_key?(attrs, "password") do
      true -> put_change(profile, :password, Password.hash_password(Map.get(attrs, "password")))
      false -> profile
    end
  end
end
