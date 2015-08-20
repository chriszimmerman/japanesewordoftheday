# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :japanese, Japanese.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "9swq0R8iHzpENPWvNFVl0ITfa3RWGKtvPv6BDh1GG8FfSg52c3b3rv4Ylb22dUGz",
  render_errors: [default_format: "html"],
  pubsub: [name: Japanese.PubSub,
           adapter: Phoenix.PubSub.PG2],
  username: System.get_env("USER"),
  password: System.get_env("PASSWORD"),
  database: System.get_env("DB")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
