defmodule RealworldElixirPhoenixWeb.ArticleControllerTest do
  use RealworldElixirPhoenixWeb.ConnCase

  import RealworldElixirPhoenix.Guardian
  import RealworldElixirPhoenix.ArticlesFixtures
  import RealworldElixirPhoenix.AccountsFixtures

  alias RealworldElixirPhoenix.Articles.Article

  @create_attrs %{
    title: "some title",
    description: "some description",
    body: "some body"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    body: "some updated body",
    slug: "some updated slug"
  }
  @invalid_attrs %{description: nil, title: nil, body: nil, slug: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all articles", %{conn: conn} do
      conn = get(conn, ~p"/api/articles")
      assert json_response(conn, 200)["articles"] == []
    end
  end

  describe "create article" do
    test "renders article when data is valid", %{conn: conn} do
      user = user_fixture()
      {:ok, token, _} = encode_and_sign(user)

      conn =
        post(conn |> put_req_header("authorization", "Token " <> token), ~p"/api/articles",
          article: @create_attrs
        )

      assert %{
               "title" => "some title",
               "body" => "some body",
               "description" => "some description",
               "slug" => "some-title"
             } = json_response(conn, 201)["article"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      {:ok, token, _} = encode_and_sign(user)

      conn =
        post(conn |> put_req_header("authorization", "Token " <> token), ~p"/api/articles",
          article: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update article" do
    setup [:create_article_context]

    test "renders article when data is valid", %{
      conn: conn,
      article: %Article{} = article,
      token: token
    } do
      conn =
        put(
          conn |> put_req_header("authorization", "Token " <> token),
          ~p"/api/articles/#{article.slug}",
          article: @update_attrs
        )

      assert %{
               "title" => "some updated title",
               "body" => "some updated body",
               "description" => "some updated description",
               "slug" => "some-updated-title"
             } = json_response(conn, 200)["article"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      article: %Article{} = article,
      token: token
    } do
      conn =
        put(
          conn |> put_req_header("authorization", "Token " <> token),
          ~p"/api/articles/#{article.slug}",
          article: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete article" do
    setup [:create_article_context]

    test "deletes chosen article", %{conn: conn, article: article, token: token} do
      conn =
        delete(
          conn |> put_req_header("authorization", "Token " <> token),
          ~p"/api/articles/#{article.slug}"
        )

      assert response(conn, 204)
    end
  end

  defp create_article_context(_) do
    user = user_fixture()
    {:ok, token, _} = encode_and_sign(user)
    article = article_fixture(%{author_id: user.id})
    %{user: user, token: token, article: article}
  end
end
