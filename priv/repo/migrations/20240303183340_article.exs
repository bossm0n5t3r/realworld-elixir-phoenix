defmodule RealworldElixirPhoenix.Repo.Migrations.Article do
  use Ecto.Migration

  def change do
    alter table("articles") do
      add :comment_id, references(:comments, on_delete: :nothing, type: :binary_id)
      add :favorite_id, references(:favorites, on_delete: :nothing, type: :binary_id)
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id)
    end
  end
end
