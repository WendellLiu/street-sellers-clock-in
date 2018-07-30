defmodule StreetSellersClockIn.AccountsTest do
  use StreetSellersClockIn.DataCase

  alias StreetSellersClockIn.Accounts

  describe "users" do
    alias StreetSellersClockIn.Accounts.User

    @valid_attrs %{alias: "some alias", avatar_id: "some avatar_id", email: "some email", password: "some password", username: "some username"}
    @update_attrs %{alias: "some updated alias", avatar_id: "some updated avatar_id", email: "some updated email", password: "some updated password", username: "some updated username"}
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

  describe "login_tokens" do
    alias StreetSellersClockIn.Accounts.LoginToken

    @valid_attrs %{expired_time: ~N[2010-04-17 14:00:00.000000], token: "some token"}
    @update_attrs %{expired_time: ~N[2011-05-18 15:01:01.000000], token: "some updated token"}
    @invalid_attrs %{expired_time: nil, token: nil}

    def login_token_fixture(attrs \\ %{}) do
      {:ok, login_token} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_login_token()

      login_token
    end

    test "list_login_tokens/0 returns all login_tokens" do
      login_token = login_token_fixture()
      assert Accounts.list_login_tokens() == [login_token]
    end

    test "get_login_token!/1 returns the login_token with given id" do
      login_token = login_token_fixture()
      assert Accounts.get_login_token!(login_token.id) == login_token
    end

    test "create_login_token/1 with valid data creates a login_token" do
      assert {:ok, %LoginToken{} = login_token} = Accounts.create_login_token(@valid_attrs)
      assert login_token.expired_time == ~N[2010-04-17 14:00:00.000000]
      assert login_token.token == "some token"
    end

    test "create_login_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_login_token(@invalid_attrs)
    end

    test "update_login_token/2 with valid data updates the login_token" do
      login_token = login_token_fixture()
      assert {:ok, login_token} = Accounts.update_login_token(login_token, @update_attrs)
      assert %LoginToken{} = login_token
      assert login_token.expired_time == ~N[2011-05-18 15:01:01.000000]
      assert login_token.token == "some updated token"
    end

    test "update_login_token/2 with invalid data returns error changeset" do
      login_token = login_token_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_login_token(login_token, @invalid_attrs)
      assert login_token == Accounts.get_login_token!(login_token.id)
    end

    test "delete_login_token/1 deletes the login_token" do
      login_token = login_token_fixture()
      assert {:ok, %LoginToken{}} = Accounts.delete_login_token(login_token)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_login_token!(login_token.id) end
    end

    test "change_login_token/1 returns a login_token changeset" do
      login_token = login_token_fixture()
      assert %Ecto.Changeset{} = Accounts.change_login_token(login_token)
    end
  end
end
