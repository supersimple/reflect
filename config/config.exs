# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :reflect, ReflectWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IOcVu6uvH+aoPmi+Yr2JQdOz04f+cH6mo8KqXIIbNCtiz5BnfMcoczrWnJp5WgJ7",
  render_errors: [view: ReflectWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Reflect.PubSub, adapter: Phoenix.PubSub.PG2],
  version: "0.1.0"

config :darkskyx,
  api_key: System.get_env("DARKSKY_API_KEY"),
  defaults: [
    units: "us",
    lang: "en",
    longitude: -104.828918,
    latitude: 39.388763
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
