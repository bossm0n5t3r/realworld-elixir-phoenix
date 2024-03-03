defmodule RealworldElixirPhoenix.Repo.Migrations.Article do
  use Ecto.Migration

  def change do
    alter table("articles") do
      add :author_id, references(:users, on_delete: :nothing, type: :binary_id)
    end
  end
end
