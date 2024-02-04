defmodule RealworldElixirPhoenix.ArticlesTest do
  use RealworldElixirPhoenix.DataCase

  alias RealworldElixirPhoenix.Articles

  describe "articles" do
    alias RealworldElixirPhoenix.Articles.Article

    import RealworldElixirPhoenix.ArticlesFixtures

    @invalid_attrs %{description: nil, title: nil, body: nil, slug: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        body: "some body",
        slug: "some slug"
      }

      assert {:ok, %Article{} = article} = Articles.create_article(valid_attrs)
      assert article.description == "some description"
      assert article.title == "some title"
      assert article.body == "some body"
      assert article.slug == "some slug"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        body: "some updated body",
        slug: "some updated slug"
      }

      assert {:ok, %Article{} = article} = Articles.update_article(article, update_attrs)
      assert article.description == "some updated description"
      assert article.title == "some updated title"
      assert article.body == "some updated body"
      assert article.slug == "some updated slug"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == Articles.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end
end
