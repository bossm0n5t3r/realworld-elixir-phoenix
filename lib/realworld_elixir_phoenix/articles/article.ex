defmodule RealworldElixirPhoenix.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldElixirPhoenix.Repo
  alias RealworldElixirPhoenix.Accounts.User
  alias RealworldElixirPhoenix.Articles.Comment
  alias RealworldElixirPhoenix.Articles.Favorite
  alias RealworldElixirPhoenix.Articles.Tag
  alias RealworldElixirPhoenix.Articles.ArticleTag

  @already_exists "ALREADY_EXISTS"

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :description, :string
    field :title, :string
    field :body, :string
    field :slug, :string

    belongs_to :author, User

    field :favorited, :boolean, virtual: true

    has_many :comments, Comment
    has_many :favorites, Favorite

    many_to_many :tagList, Tag, join_through: ArticleTag, on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body, :author_id])
    |> cast_assoc(:author)
    |> put_assoc(:tagList, parse_tags(attrs))
    |> validate_required([:title, :description, :body])
    |> title_to_slugify()
    |> unique_constraint(:slug, message: @already_exists)
  end

  def title_to_slugify(changeset) do
    case get_change(changeset, :title) do
      nil -> changeset
      title -> put_change(changeset, :slug, slugify(title))
    end
  end

  defp slugify(title) do
    title |> String.downcase() |> String.replace(~r/[^\w-]+/u, "-")
  end

  defp parse_tags(params) do
    (params["tagList"] || params[:tagList] || [])
    |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    Repo.get_by(Tag, name: name) ||
      Repo.insert!(%Tag{name: name})
  end
end
