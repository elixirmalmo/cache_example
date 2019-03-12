# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cache_example,
  ecto_repos: [CacheExample.Repo]

# Configures the endpoint
config :cache_example, CacheExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sgsUnFca0XI0qn9+ABwraq4uRiEIaxo9RAkgYHK9uVAvTiyhEUcUpcESxhjWKOMf",
  render_errors: [view: CacheExampleWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CacheExample.PubSub, adapter: Phoenix.PubSub.PG2],
  debug_errors: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
