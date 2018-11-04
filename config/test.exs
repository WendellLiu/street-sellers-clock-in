use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :street_sellers_clock_in, StreetSellersClockInWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :street_sellers_clock_in, StreetSellersClockIn.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "root",
  password: "1qaz2wsx",
  database: "street_sellers_clock_in_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
