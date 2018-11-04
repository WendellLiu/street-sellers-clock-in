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
CMD ["sh","-c", "mix ecto.create && mix ecto.migrate && mix phx.server"]
