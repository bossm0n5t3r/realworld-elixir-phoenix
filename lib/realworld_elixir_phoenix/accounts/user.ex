defmodule RealworldElixirPhoenix.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Bcrypt

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
    |> put_pass_hash
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, %{password: hash_pwd_salt(password)})
  end

  defp put_pass_hash(changeset), do: changeset
end
