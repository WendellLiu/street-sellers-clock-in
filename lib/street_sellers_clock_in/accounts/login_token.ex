defmodule StreetSellersClockIn.Accounts.LoginToken do
  use Ecto.Schema
  import Ecto.Changeset


  schema "login_tokens" do
    field :expired_time, :naive_datetime
    field :salt, :string
    field :token, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(login_token, attrs) do
    login_token
    |> cast(attrs, [:token, :salt, :expired_time])
    |> validate_required([:token, :salt, :expired_time])
  end
end
