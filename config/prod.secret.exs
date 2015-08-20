use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :japanese, Japanese.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :japanese, Japanese.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("USER"),
  password: System.get_env("PASSWORD"),
  database: "dafjdjsjrmvlm5",
  pool_size: 20 # The amount of database connections in the pool
