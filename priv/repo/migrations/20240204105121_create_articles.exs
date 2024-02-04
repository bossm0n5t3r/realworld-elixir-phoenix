defmodule RealworldElixirPhoenix.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :slug, :string
      add :body, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
