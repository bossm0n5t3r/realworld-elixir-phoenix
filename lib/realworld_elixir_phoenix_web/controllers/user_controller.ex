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

  def show(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    {:ok, token, _} = encode_and_sign(user)
    render(conn, :users, user: user, token: token)
  end

  def update(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      {:ok, token, _} = encode_and_sign(user)

      render(conn, :users, user: user, token: token)
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

    case Bcrypt.verify_pass(password, user.password) do
      true ->
        {:ok, token, _} = encode_and_sign(user)
        render(conn, :users, user: user, token: token)

      false ->
        send_resp(conn, :unauthorized, "")
    end
  end
end
