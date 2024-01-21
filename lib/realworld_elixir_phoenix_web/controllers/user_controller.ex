defmodule RealworldElixirPhoenixWeb.UserController do
  use RealworldElixirPhoenixWeb, :controller

  alias RealworldElixirPhoenix.Accounts
  alias RealworldElixirPhoenix.Accounts.User

  import RealworldElixirPhoenix.Guardian

  action_fallback RealworldElixirPhoenixWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      {:ok, token, _} = encode_and_sign(user)

      conn
      |> put_status(:created)
      |> render(:users, user: user, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_all(conn, _params) do
    with {_count, _users} <- Accounts.delete_all_users() do
      send_resp(conn, :no_content, "")
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    user = Accounts.get_user_by_email(email)
    # TODO add password hashing
    if user && user.password == password do
      {:ok, token, _} = encode_and_sign(user)

      conn
      |> render(:users, user: user, token: token)
    else
      send_resp(conn, :unauthorized, "")
    end
  end
end
