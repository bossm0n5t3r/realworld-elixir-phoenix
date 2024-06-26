defmodule RealworldElixirPhoenix.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RealworldElixirPhoenix.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        bio: "some bio",
        email: unique_user_email(),
        image: "some image",
        password: "some password",
        username: "some username"
      })
      |> RealworldElixirPhoenix.Accounts.create_user()

    user
  end
end
