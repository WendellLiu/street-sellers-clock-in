defmodule StreetSellersClockIn.Accounts.LoginInvitationCode do
  use Ecto.Schema
  import Ecto.Changeset


  schema "login_invitation_code" do
    field :expired_time, :naive_datetime
    field :invitation_code, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(login_invitation_code, attrs) do
    login_invitation_code
    |> cast(attrs, [:invitation_code, :expired_time])
    |> validate_required([:invitation_code, :expired_time])
  end
end
