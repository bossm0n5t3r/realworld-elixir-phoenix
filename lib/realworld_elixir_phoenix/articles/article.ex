defmodule RealworldElixirPhoenix.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :description, :string
    field :title, :string
    field :body, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :slug, :body, :description])
    |> validate_required([:title, :slug, :body, :description])
  end
end
