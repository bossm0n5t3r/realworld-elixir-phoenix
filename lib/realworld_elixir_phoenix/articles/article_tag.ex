defmodule RealworldElixirPhoenix.Articles.ArticleTag do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldElixirPhoenix.Articles.Article
  alias RealworldElixirPhoenix.Articles.Tag

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "article_tags" do
    belongs_to :article, Article
    belongs_to :tag, Tag

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article_tag, attrs) do
    article_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
