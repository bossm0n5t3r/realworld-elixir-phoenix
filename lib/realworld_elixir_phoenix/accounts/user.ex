defmodule RealworldElixirPhoenix.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :image, :string
    field :username, :string
    field :password, :string
    field :email, :string
    field :bio, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :bio, :image])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
  end
end
