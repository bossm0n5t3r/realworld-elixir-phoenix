defmodule RealworldElixirPhoenix.AccountsTest do
  use RealworldElixirPhoenix.DataCase

  alias RealworldElixirPhoenix.Accounts

  describe "users" do
    alias RealworldElixirPhoenix.Accounts.User

    import RealworldElixirPhoenix.AccountsFixtures

    @invalid_attrs %{image: nil, username: nil, password: nil, email: nil, bio: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        image: "some image",
        username: "some username",
        password: "some password",
        email: "some email",
        bio: "some bio"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.image == "some image"
      assert user.username == "some username"
      assert user.password == "some password"
      assert user.email == "some email"
      assert user.bio == "some bio"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        image: "some updated image",
        username: "some updated username",
        password: "some updated password",
        email: "some updated email",
        bio: "some updated bio"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.image == "some updated image"
      assert user.username == "some updated username"
      assert user.password == "some updated password"
      assert user.email == "some updated email"
      assert user.bio == "some updated bio"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
