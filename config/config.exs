# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :realworld_elixir_phoenix,
  ecto_repos: [RealworldElixirPhoenix.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :realworld_elixir_phoenix, RealworldElixirPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: RealworldElixirPhoenixWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: RealworldElixirPhoenix.PubSub,
  live_view: [signing_salt: "BUF+ZrY9"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :realworld_elixir_phoenix, RealworldElixirPhoenix.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :realworld_elixir_phoenix, RealworldElixirPhoenix.Guardian,
  issuer: "realworld_elixir_phoenix",
  secret_key: "LhR5tiljWFccS7lT88OzOfiuaBhrPFWuHG9aaXspc55sS4jMKSm6lKFQgQypVHSD"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
