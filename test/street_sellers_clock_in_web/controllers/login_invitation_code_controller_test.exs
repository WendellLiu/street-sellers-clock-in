defmodule StreetSellersClockInWeb.LoginInvitationCodeControllerTest do
  use StreetSellersClockInWeb.ConnCase

  alias StreetSellersClockIn.Accounts
  alias StreetSellersClockIn.Accounts.LoginInvitationCode

  @create_attrs %{expired_time: ~N[2010-04-17 14:00:00.000000], invitation_code: "some invitation_code"}
  @update_attrs %{expired_time: ~N[2011-05-18 15:01:01.000000], invitation_code: "some updated invitation_code"}
  @invalid_attrs %{expired_time: nil, invitation_code: nil}

  def fixture(:login_invitation_code) do
    {:ok, login_invitation_code} = Accounts.create_login_invitation_code(@create_attrs)
    login_invitation_code
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all login_invitation_code", %{conn: conn} do
      conn = get conn, login_invitation_code_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create login_invitation_code" do
    test "renders login_invitation_code when data is valid", %{conn: conn} do
      conn = post conn, login_invitation_code_path(conn, :create), login_invitation_code: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, login_invitation_code_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "expired_time" => ~N[2010-04-17 14:00:00.000000],
        "invitation_code" => "some invitation_code"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, login_invitation_code_path(conn, :create), login_invitation_code: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update login_invitation_code" do
    setup [:create_login_invitation_code]

    test "renders login_invitation_code when data is valid", %{conn: conn, login_invitation_code: %LoginInvitationCode{id: id} = login_invitation_code} do
      conn = put conn, login_invitation_code_path(conn, :update, login_invitation_code), login_invitation_code: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, login_invitation_code_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "expired_time" => ~N[2011-05-18 15:01:01.000000],
        "invitation_code" => "some updated invitation_code"}
    end

    test "renders errors when data is invalid", %{conn: conn, login_invitation_code: login_invitation_code} do
      conn = put conn, login_invitation_code_path(conn, :update, login_invitation_code), login_invitation_code: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete login_invitation_code" do
    setup [:create_login_invitation_code]

    test "deletes chosen login_invitation_code", %{conn: conn, login_invitation_code: login_invitation_code} do
      conn = delete conn, login_invitation_code_path(conn, :delete, login_invitation_code)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, login_invitation_code_path(conn, :show, login_invitation_code)
      end
    end
  end

  defp create_login_invitation_code(_) do
    login_invitation_code = fixture(:login_invitation_code)
    {:ok, login_invitation_code: login_invitation_code}
  end
end
