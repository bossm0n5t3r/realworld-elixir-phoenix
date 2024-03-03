defmodule RealworldElixirPhoenix.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :string
      add :author, references(:users, on_delete: :nothing, type: :binary_id)
      add :article, references(:articles, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:comments, [:author])
    create index(:comments, [:article])
  end
end
