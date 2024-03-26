defmodule RealworldElixirPhoenixWeb.TagJSON do
  alias RealworldElixirPhoenix.Articles.Tag

  @doc """
  Renders a list of tags.
  """
  def index(%{tags: tags}) do
    %{data: for(tag <- tags, do: data(tag))}
  end

  defp data(%Tag{} = tag) do
    %{
      id: tag.id,
      name: tag.name
    }
  end
end
