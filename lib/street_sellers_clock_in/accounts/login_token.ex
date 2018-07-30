defmodule StreetSellersClockIn.Accounts.LoginToken do
  use Ecto.Schema
  import Ecto.Changeset


  schema "login_tokens" do
    field :expired_time, :naive_datetime
    field :token, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(login_token, attrs) do
    login_token
    |> cast(attrs, [:token, :expired_time, :user_id])
    |> validate_required([:token, :user_id])
  end
end
