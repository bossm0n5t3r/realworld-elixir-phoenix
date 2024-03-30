defmodule RealworldElixirPhoenixWeb.TagJSON do
  alias RealworldElixirPhoenix.Articles.Tag

  @doc """
  Renders a list of tags.
  """
  def index(%{tags: tags}) do
    %{tags: for(tag <- tags, do: data(tag))}
  end

  defp data(%Tag{} = tag) do
    tag.name
  end
end
