defmodule RealworldElixirPhoenix.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user, references(:users, on_delete: :nothing, type: :binary_id)
      add :article, references(:articles, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:favorites, [:user])
    create index(:favorites, [:article])
  end
end
