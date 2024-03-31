defmodule RealworldElixirPhoenix.Articles.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldElixirPhoenix.Accounts.User
  alias RealworldElixirPhoenix.Articles.Article

  @already_exists "ALREADY_EXISTS"

  @primary_key false
  @foreign_key_type :binary_id
  schema "favorites" do
    belongs_to(:user, User, primary_key: true)
    belongs_to(:article, Article, primary_key: true)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:user_id, :article_id])
    |> validate_required([:user_id, :article_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:article_id)
    |> unique_constraint(
      [:user_id, :article_id],
      name: :favorites_user_id_article_id_index,
      message: @already_exists
    )
  end
end
