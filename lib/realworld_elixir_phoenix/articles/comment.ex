defmodule RealworldElixirPhoenix.Articles.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias RealworldElixirPhoenix.Accounts.User
  alias RealworldElixirPhoenix.Articles.Article

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :body, :string
    belongs_to :author, User
    belongs_to :article, Article

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :author_id, :article_id])
    |> validate_required([:body, :author_id, :article_id])
  end
end
