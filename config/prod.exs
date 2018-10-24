use Mix.Config

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# StreetSellersClockInWeb.Endpoint.init/2 when load_from_system_env is
# true. Any dynamic configuration should be done there.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phx.digest task
# which you typically run after static files are built.
config :street_sellers_clock_in, StreetSellersClockInWeb.Endpoint,
  load_from_system_env: true,
  # url: [host: "example.com", port: 80],
  http: [port: System.get_env("PORT")],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("WEB_API_SERVER_SECRET")

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :street_sellers_clock_in, StreetSellersClockIn.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: "street_sellers_clock_in_prod",
  hostname: System.get_env("POSTGRES_HOSTNAME"),
  port: System.get_env("POSTGRES_PORT"),
  pool_size: 15

config :street_sellers_clock_in, StreetSellersClockIn.Guardian,
  issuer: System.get_env("WEB_API_SERVER_SECRET"),
  secret_key: "Secret key. You can use `mix guardian.gen.secret` to get one",
  token_ttl: %{
    "access" => {1, :days},
    "refresh" => {52, :weeks}
  }

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :street_sellers_clock_in, StreetSellersClockInWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [:inet6,
#               port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :street_sellers_clock_in, StreetSellersClockInWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :street_sellers_clock_in, StreetSellersClockInWeb.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.
# import_config "prod.secret.exs"
