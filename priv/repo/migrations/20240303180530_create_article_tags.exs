defmodule RealworldElixirPhoenix.Repo.Migrations.CreateArticleTags do
  use Ecto.Migration

  def change do
    create table(:article_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :article, references(:articles, on_delete: :nothing, type: :binary_id)
      add :tag, references(:tags, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:article_tags, [:article])
    create index(:article_tags, [:tag])
  end
end
