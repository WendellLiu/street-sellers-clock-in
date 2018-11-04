defmodule StreetSellersClockIn.AccountsTest do
  use StreetSellersClockIn.DataCase

  alias StreetSellersClockIn.Accounts

  describe "users" do
    alias StreetSellersClockIn.Accounts.User

    @valid_attrs %{
      alias: "some alias",
      avatar_id: "some avatar_id",
      email: "some email",
      password: "some password",
      username: "some username"
    }
    @update_attrs %{
      alias: "some updated alias",
      avatar_id: "some updated avatar_id",
      email: "some updated email",
      password: "some updated password",
      username: "some updated username"
    }
    @invalid_attrs %{alias: nil, avatar_id: nil, email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.alias == "some alias"
      assert user.avatar_id == "some avatar_id"
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.alias == "some updated alias"
      assert user.avatar_id == "some updated avatar_id"
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "login_invitation_code" do
    alias StreetSellersClockIn.Accounts.LoginInvitationCode

    @valid_attrs %{
      expired_time: ~N[2010-04-17 14:00:00.000000],
      invitation_code: "some invitation_code"
    }
    @update_attrs %{
      expired_time: ~N[2011-05-18 15:01:01.000000],
      invitation_code: "some updated invitation_code"
    }
    @invalid_attrs %{expired_time: nil, invitation_code: nil}

    def login_invitation_code_fixture(attrs \\ %{}) do
      {:ok, login_invitation_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_login_invitation_code()

      login_invitation_code
    end

    test "list_login_invitation_code/0 returns all login_invitation_code" do
      login_invitation_code = login_invitation_code_fixture()
      assert Accounts.list_login_invitation_code() == [login_invitation_code]
    end

    test "get_login_invitation_code!/1 returns the login_invitation_code with given id" do
      login_invitation_code = login_invitation_code_fixture()

      assert Accounts.get_login_invitation_code!(login_invitation_code.id) ==
               login_invitation_code
    end

    test "create_login_invitation_code/1 with valid data creates a login_invitation_code" do
      assert {:ok, %LoginInvitationCode{} = login_invitation_code} =
               Accounts.create_login_invitation_code(@valid_attrs)

      assert login_invitation_code.expired_time == ~N[2010-04-17 14:00:00.000000]
      assert login_invitation_code.invitation_code == "some invitation_code"
    end

    test "create_login_invitation_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_login_invitation_code(@invalid_attrs)
    end

    test "update_login_invitation_code/2 with valid data updates the login_invitation_code" do
      login_invitation_code = login_invitation_code_fixture()

      assert {:ok, login_invitation_code} =
               Accounts.update_login_invitation_code(login_invitation_code, @update_attrs)

      assert %LoginInvitationCode{} = login_invitation_code
      assert login_invitation_code.expired_time == ~N[2011-05-18 15:01:01.000000]
      assert login_invitation_code.invitation_code == "some updated invitation_code"
    end

    test "update_login_invitation_code/2 with invalid data returns error changeset" do
      login_invitation_code = login_invitation_code_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_login_invitation_code(login_invitation_code, @invalid_attrs)

      assert login_invitation_code ==
               Accounts.get_login_invitation_code!(login_invitation_code.id)
    end

    test "delete_login_invitation_code/1 deletes the login_invitation_code" do
      login_invitation_code = login_invitation_code_fixture()

      assert {:ok, %LoginInvitationCode{}} =
               Accounts.delete_login_invitation_code(login_invitation_code)

      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_login_invitation_code!(login_invitation_code.id)
      end
    end

    test "change_login_invitation_code/1 returns a login_invitation_code changeset" do
      login_invitation_code = login_invitation_code_fixture()
      assert %Ecto.Changeset{} = Accounts.change_login_invitation_code(login_invitation_code)
    end
  end
end
