defmodule RealworldElixirPhoenixWeb.ArticleJSON do
  alias RealworldElixirPhoenix.Articles.Article
  alias RealworldElixirPhoenix.Accounts.User

  @doc """
  Renders a list of articles.
  """
  def index(%{articles: articles}) do
    %{
      articles: for(article <- articles, do: data(article)),
      articlesCount: length(articles)
    }
  end

  @doc """
  Renders a single article.
  """
  def show(%{article: article}) do
    %{article: data(article)}
  end

  defp data(%Article{} = article) do
    %{
      slug: article.slug,
      title: article.title,
      description: article.description,
      body: article.body,
      tagList: for(tag <- article.tagList, do: tag.name),
      favoritesCount: article.favorites |> Enum.count(),
      favorited: article.favorited,
      createdAt:
        article.inserted_at
        |> DateTime.truncate(:millisecond)
        |> DateTime.to_iso8601(:extended, 0),
      updatedAt:
        article.updated_at
        |> DateTime.truncate(:millisecond)
        |> DateTime.to_iso8601(:extended, 0),
      author: data(article.author)
    }
  end

  defp data(%User{} = author) do
    %{
      username: author.username,
      bio: author.bio,
      image: author.image,
      following: author.following
    }
  end
end
