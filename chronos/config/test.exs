use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chronos, Chronos.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :chronos, Chronos.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chronos_test",
  pool: Ecto.Adapters.SQL.Sandbox
