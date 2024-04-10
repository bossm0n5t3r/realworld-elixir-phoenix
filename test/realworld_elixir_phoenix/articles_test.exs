defmodule RealworldElixirPhoenix.ArticlesTest do
  use RealworldElixirPhoenix.DataCase

  alias RealworldElixirPhoenix.Articles

  describe "articles" do
    alias RealworldElixirPhoenix.Articles.Article

    import RealworldElixirPhoenix.AccountsFixtures
    import RealworldElixirPhoenix.ArticlesFixtures

    @invalid_attrs %{description: nil, title: nil, body: nil, slug: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert_two_article_lists_are_equal([article], Articles.list_articles())
    end

    test "get_article!/1 returns the article with given id" do
      user = user_fixture()
      article = article_fixture(%{author_id: user.id})

      assert_two_articles_are_equal(article, Articles.get_article!(article.id))
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{
        title: "some title",
        description: "some description",
        body: "some body"
      }

      assert {:ok, %Article{} = article} = Articles.create_article(valid_attrs)
      assert article.title == "some title"
      assert article.description == "some description"
      assert article.body == "some body"
      assert article.slug == "some-title"
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
      assert article.title == "some updated title"
      assert article.description == "some updated description"
      assert article.body == "some updated body"
      assert article.slug == "some-updated-title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      user = user_fixture()
      article = article_fixture(%{author_id: user.id})
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert_two_articles_are_equal(article, Articles.get_article!(article.id))
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

    defp assert_two_articles_are_equal(expected_article, actual_article) do
      assert expected_article.id == actual_article.id
      assert expected_article.author_id == actual_article.author_id
      assert expected_article.title == actual_article.title
      assert expected_article.slug == actual_article.slug
      assert expected_article.body == actual_article.body
    end

    defp assert_two_article_lists_are_equal(expected_articles, actual_articles) do
      assert length(expected_articles) == length(actual_articles)

      for expected_article <- expected_articles, actual_article <- actual_articles do
        assert_two_articles_are_equal(expected_article, actual_article)
      end
    end
  end
end
