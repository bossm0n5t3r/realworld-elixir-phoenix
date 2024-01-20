defmodule RealworldElixirPhoenixWeb.UserJSON do
  alias RealworldElixirPhoenix.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def users(%{user: user, token: token}) do
    %{user: user_data(user, token)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      password: user.password
    }
  end

  defp user_data(user, token) do
    %{
      email: user.email,
      token: token,
      username: user.username,
      bio: user.bio,
      image: user.image
    }
  end
end
