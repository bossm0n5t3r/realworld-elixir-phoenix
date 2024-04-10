defmodule RealworldElixirPhoenixWeb.UserControllerTest do
  use RealworldElixirPhoenixWeb.ConnCase

  import RealworldElixirPhoenix.Guardian
  import RealworldElixirPhoenix.AccountsFixtures

  @create_attrs %{
    username: "some username",
    password: "some password",
    email: "some email"
  }
  @update_attrs %{
    username: "some updated username",
    password: "some updated password",
    email: "some updated email"
  }
  @invalid_attrs %{username: nil, password: nil, email: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"email" => email} = json_response(conn, 201)["user"]

      conn =
        post(conn, ~p"/api/users/login",
          user: %{"email" => email, "password" => @create_attrs.password}
        )

      assert %{
               "email" => "some email",
               "username" => "some username"
             } = json_response(conn, 200)["user"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{
      conn: conn,
      token: token
    } do
      conn =
        put(conn |> put_req_header("authorization", "Token " <> token), ~p"/api/user",
          user: @update_attrs
        )

      assert %{
               "email" => "some updated email",
               "username" => "some updated username"
             } = json_response(conn, 200)["user"]
    end
  end

  defp create_user(_) do
    user = user_fixture()
    {:ok, token, _} = encode_and_sign(user)
    %{user: user, token: token}
  end
end
