defmodule RealworldElixirPhoenixWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use RealworldElixirPhoenixWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(
      html: RealworldElixirPhoenixWeb.ErrorHTML,
      json: RealworldElixirPhoenixWeb.ErrorJSON
    )
    |> render(:"404")
  end

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(RealworldElixirPhoenixWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> put_view(
      html: RealworldElixirPhoenixWeb.ErrorHTML,
      json: RealworldElixirPhoenixWeb.ErrorJSON
    )
    |> render(:"404")
  end
end
