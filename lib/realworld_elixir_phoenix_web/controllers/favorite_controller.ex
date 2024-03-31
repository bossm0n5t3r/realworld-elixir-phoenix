defmodule RealworldElixirPhoenixWeb.FavoriteController do
  use RealworldElixirPhoenixWeb, :controller

  alias RealworldElixirPhoenix.Articles
  alias RealworldElixirPhoenix.Articles.Favorite
  alias RealworldElixirPhoenix.Articles.Article

  action_fallback RealworldElixirPhoenixWeb.FallbackController

  def create(conn, %{"slug" => slug}) do
    with user <- Guardian.Plug.current_resource(conn),
         %Article{} = article <- Articles.get_article_by_slug(slug),
         {:ok, %Favorite{}} <- Articles.create_favorite(user, article) do
      # refech article data
      article =
        Articles.get_article_by_slug(slug, user)
        |> Articles.article_preload()

      conn
      |> put_status(:created)
      |> render(:show, article: article)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    with user <- Guardian.Plug.current_resource(conn),
         %Article{} = article <-
           Articles.get_article_by_slug(slug, user)
           |> Articles.article_preload(),
         {1, _} <- Articles.delete_favorite(user, article) do
      conn
      |> render(:show,
        article:
          article
          |> Map.update!(:favorited, fn _ -> false end)
      )
    end
  end
end
