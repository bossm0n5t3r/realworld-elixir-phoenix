defmodule RealworldElixirPhoenix.ArticlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RealworldElixirPhoenix.Articles` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        body: "some body",
        description: "some description",
        slug: "some slug",
        title: "some title"
      })
      |> RealworldElixirPhoenix.Articles.create_article()

    article
  end
end
