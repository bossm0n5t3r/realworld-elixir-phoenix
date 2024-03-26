defmodule RealworldElixirPhoenixWeb.TagController do
  use RealworldElixirPhoenixWeb, :controller

  alias RealworldElixirPhoenix.Articles

  action_fallback RealworldPhoenixWeb.FallbackController

  def index(conn, _params) do
    render(conn, :index, tags: Articles.list_tags())
  end
end
