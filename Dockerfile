FROM elixir:1.7

COPY . /app

WORKDIR /app

ARG MIX_ENV

# Initial setup
RUN mix local.hex --force
RUN mix local.rebar
RUN mix deps.get --only prod
RUN mix compile


# Finally run the server
CMD ["sh","-c", "MIX_ENV=${MIX_ENV} mix ecto.create && MIX_ENV=${MIX_ENV} mix ecto.migrate && PORT=${PORT} MIX_ENV=${MIX_ENV} mix phx.server"]
