defmodule RealworldElixirPhoenix.Repo.Migrations.Initial do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :email, :string
      add :password, :string
      add :bio, :string
      add :image, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])

    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :slug, :string
      add :body, :string
      add :description, :string
      add :tagList, {:array, :string}
      add :favoritesCount, :integer
      add :author_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create table(:tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tags, [:name])

    create table(:article_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :article_id, references(:articles, on_delete: :nothing, type: :binary_id)
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :string
      add :author_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :article_id, references(:articles, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:comments, [:author_id])
    create index(:comments, [:article_id])

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
