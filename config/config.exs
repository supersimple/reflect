# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :reflect, ReflectWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pk6Rfad3V472DQuiorJmyqHBY5tg0wVRp9kBWzgr1yaKYoBEwbiLfCaFcgANZFrx",
  render_errors: [view: ReflectWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Reflect.PubSub,
  live_view: [signing_salt: "9ZUdzmDz"]

config :reflect,
  climacell_api_key: System.get_env("CLIMACELL_API_KEY"),
  longitude: -104.828918,
  latitude: 39.388763,
  timezone: "America/Denver"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :rollbax,
  access_token: System.get_env("ROLLBAR_TOKEN"),
  environment: "prod",
  enable_crash_reports: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
