defmodule RealworldElixirPhoenixWeb.CommentJSON do
  alias RealworldElixirPhoenix.Articles.Comment
  alias RealworldElixirPhoenix.Accounts.User

  def list(%{comments: comments}) do
    %{comments: for(comment <- comments, do: data(comment))}
  end

  def show(%{comment: comment}) do
    %{comment: data(comment)}
  end

  defp data(%Comment{} = comment) do
    %{
      id: comment.id,
      createdAt:
        comment.inserted_at
        |> DateTime.truncate(:millisecond)
        |> DateTime.to_iso8601(:extended, 0),
      updatedAt:
        comment.updated_at
        |> DateTime.truncate(:millisecond)
        |> DateTime.to_iso8601(:extended, 0),
      body: comment.body,
      author: data(comment.author)
    }
  end

  defp data(%User{} = author) do
    %{
      username: author.username,
      bio: author.bio,
      image: author.image,
      following:
        case author.following do
          nil -> false
          following -> following
        end
    }
  end
end
