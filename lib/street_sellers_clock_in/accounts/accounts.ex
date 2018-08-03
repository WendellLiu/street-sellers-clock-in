defmodule StreetSellersClockIn.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias StreetSellersClockIn.Repo

  alias StreetSellersClockIn.Accounts.User
  alias StreetSellersClockIn.ClockIn.ClockRecord

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_attr!(attr), do: User |> Repo.get_by(attr)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_expired_users do
    now = NaiveDateTime.utc_now
    sub_clock_record = from(p_c in ClockRecord, where: p_c.planned_clock_out_time < ^now)

    users = from u in User,
      join: c in subquery(sub_clock_record) , on: u.clock_record_id == c.id,
      select: %{
        "clock_record_id" => c.id,
      }
    users |> Repo.all
  end

  alias StreetSellersClockIn.Accounts.LoginToken

  @doc """
  Returns the list of login_tokens.

  ## Examples

      iex> list_login_tokens()
      [%LoginToken{}, ...]

  """
  def list_login_tokens do
    Repo.all(LoginToken)
  end

  @doc """
  Gets a single login_token.

  Raises `Ecto.NoResultsError` if the Login token does not exist.

  ## Examples

      iex> get_login_token!(123)
      %LoginToken{}

      iex> get_login_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_login_token!(id), do: Repo.get!(LoginToken, id)

  @doc """
  Creates a login_token.

  ## Examples

      iex> create_login_token(%{field: value})
      {:ok, %LoginToken{}}

      iex> create_login_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_login_token(attrs \\ %{}) do
    %LoginToken{}
    |> LoginToken.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a login_token.

  ## Examples

      iex> update_login_token(login_token, %{field: new_value})
      {:ok, %LoginToken{}}

      iex> update_login_token(login_token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_login_token(%LoginToken{} = login_token, attrs) do
    login_token
    |> LoginToken.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LoginToken.

  ## Examples

      iex> delete_login_token(login_token)
      {:ok, %LoginToken{}}

      iex> delete_login_token(login_token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_login_token(%LoginToken{} = login_token) do
    Repo.delete(login_token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking login_token changes.

  ## Examples

      iex> change_login_token(login_token)
      %Ecto.Changeset{source: %LoginToken{}}

  """
  def change_login_token(%LoginToken{} = login_token) do
    LoginToken.changeset(login_token, %{})
  end

  alias StreetSellersClockIn.Accounts.LoginInvitationCode

  @doc """
  Returns the list of login_invitation_code.

  ## Examples

      iex> list_login_invitation_code()
      [%LoginInvitationCode{}, ...]

  """
  def list_login_invitation_code do
    Repo.all(LoginInvitationCode)
  end

  @doc """
  Gets a single login_invitation_code.

  Raises `Ecto.NoResultsError` if the Login invitation code does not exist.

  ## Examples

      iex> get_login_invitation_code!(123)
      %LoginInvitationCode{}

      iex> get_login_invitation_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_login_invitation_code!(id), do: Repo.get!(LoginInvitationCode, id)

  def get_active_login_invitation_code_by_attr!(attr) do
    now = NaiveDateTime.utc_now
    sub_login_invitation_code = from(p_c in LoginInvitationCode, where: p_c.expired_time > ^now)

    sub_login_invitation_code |> Repo.get_by(attr)
  end
  @doc """
  Creates a login_invitation_code.

  ## Examples

      iex> create_login_invitation_code(%{field: value})
      {:ok, %LoginInvitationCode{}}

      iex> create_login_invitation_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_login_invitation_code(attrs \\ %{}) do
    %LoginInvitationCode{}
    |> LoginInvitationCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a login_invitation_code.

  ## Examples

      iex> update_login_invitation_code(login_invitation_code, %{field: new_value})
      {:ok, %LoginInvitationCode{}}

      iex> update_login_invitation_code(login_invitation_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_login_invitation_code(%LoginInvitationCode{} = login_invitation_code, attrs) do
    login_invitation_code
    |> LoginInvitationCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LoginInvitationCode.

  ## Examples

      iex> delete_login_invitation_code(login_invitation_code)
      {:ok, %LoginInvitationCode{}}

      iex> delete_login_invitation_code(login_invitation_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_login_invitation_code(%LoginInvitationCode{} = login_invitation_code) do
    Repo.delete(login_invitation_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking login_invitation_code changes.

  ## Examples

      iex> change_login_invitation_code(login_invitation_code)
      %Ecto.Changeset{source: %LoginInvitationCode{}}

  """
  def change_login_invitation_code(%LoginInvitationCode{} = login_invitation_code) do
    LoginInvitationCode.changeset(login_invitation_code, %{})
  end
end
