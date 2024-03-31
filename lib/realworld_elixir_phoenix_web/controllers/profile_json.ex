defmodule RealworldElixirPhoenixWeb.ProfileJSON do
  alias RealworldElixirPhoenix.Accounts.User

  def index(%{profile: profile, following: following}) do
    %{profile: data(profile, following)}
  end

  defp data(%User{} = profile, following) do
    %{
      username: profile.username,
      bio: profile.bio,
      image: profile.image,
      following: following
    }
  end
end
