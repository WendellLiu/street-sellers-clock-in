defmodule StreetSellersClockInWeb.LoginTokenControllerTest do
  use StreetSellersClockInWeb.ConnCase

  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.Accounts.LoginToken

  @create_attrs %{expired_time: ~N[2010-04-17 14:00:00.000000], salt: "some salt", token: "some token"}
  @update_attrs %{expired_time: ~N[2011-05-18 15:01:01.000000], salt: "some updated salt", token: "some updated token"}
  @invalid_attrs %{expired_time: nil, salt: nil, token: nil}

  def fixture(:login_token) do
    {:ok, login_token} = Accounts.create_login_token(@create_attrs)
    login_token
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all login_tokens", %{conn: conn} do
      conn = get conn, login_token_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create login_token" do
    test "renders login_token when data is valid", %{conn: conn} do
      conn = post conn, login_token_path(conn, :create), login_token: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, login_token_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "expired_time" => ~N[2010-04-17 14:00:00.000000],
        "salt" => "some salt",
        "token" => "some token"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, login_token_path(conn, :create), login_token: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update login_token" do
    setup [:create_login_token]

    test "renders login_token when data is valid", %{conn: conn, login_token: %LoginToken{id: id} = login_token} do
      conn = put conn, login_token_path(conn, :update, login_token), login_token: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, login_token_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "expired_time" => ~N[2011-05-18 15:01:01.000000],
        "salt" => "some updated salt",
        "token" => "some updated token"}
    end

    test "renders errors when data is invalid", %{conn: conn, login_token: login_token} do
      conn = put conn, login_token_path(conn, :update, login_token), login_token: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete login_token" do
    setup [:create_login_token]

    test "deletes chosen login_token", %{conn: conn, login_token: login_token} do
      conn = delete conn, login_token_path(conn, :delete, login_token)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, login_token_path(conn, :show, login_token)
      end
    end
  end

  defp create_login_token(_) do
    login_token = fixture(:login_token)
    {:ok, login_token: login_token}
  end
end
