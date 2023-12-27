defmodule RealworldElixirPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :realworld_elixir_phoenix,
    adapter: Ecto.Adapters.Postgres
end
