FROM elixir:1.6

COPY . /app

WORKDIR /app

ARG PORT

ENV MIX_ENV prod
ENV PORT ${PORT}

# Initial setup
RUN mix local.hex --force
RUN mix local.rebar
RUN mix deps.get --only prod
RUN mix compile


# Finally run the server
CMD ["sh","-c", "MIX_ENV=${MIX_ENV} mix ecto.create && MIX_ENV=${MIX_ENV} mix ecto.migrate && PORT=${PORT} MIX_ENV=${MIX_ENV} mix phx.server"]