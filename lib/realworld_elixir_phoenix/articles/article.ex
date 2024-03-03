defmodule RealworldElixirPhoenix.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldElixirPhoenix.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :description, :string
    field :title, :string
    field :body, :string
    field :slug, :string

    belongs_to :author, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body, :author_id])
    |> cast_assoc(:author)
    |> validate_required([:title, :description, :body])
    |> title_to_slugify()
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
end
