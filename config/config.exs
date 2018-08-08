# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :street_sellers_clock_in,
  ecto_repos: [StreetSellersClockIn.Repo]

# Configures the endpoint
config :street_sellers_clock_in, StreetSellersClockInWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wiJwSHJ9YxqlYB6ToKJEYmHjPI/1uD9BwzOKG0ORYxMnHA97seZ7Ou4uqyj7tGUg",
  render_errors: [view: StreetSellersClockInWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: StreetSellersClockIn.PubSub,
           adapter: Phoenix.PubSub.PG2],
  invitation_code_length: 5

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

alias StreetSellersClockIn.Accounts.Helpers
# configure scheduler
config :street_sellers_clock_in, StreetSellersClockIn.Scheduler,
  jobs: [
    # Every 30 minutes
    {"*/30 * * * *", fn -> Helpers.clock_out_expired_record end},
    {"*/60 * * * *", fn -> StreetSellersClockIn.StartupTask.warm end},
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
