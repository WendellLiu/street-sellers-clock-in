defmodule StreetSellersClockIn.Repo.Migrations.CreateLoginInvitationCode do
  use Ecto.Migration

  def change do
    create table(:login_invitation_code) do
      add :invitation_code, :string
      add :expired_time, :naive_datetime
      add :is_active, :boolean, default: true
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:login_invitation_code, [:user_id, :invitation_code])
  end
end
