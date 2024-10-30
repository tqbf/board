FROM elixir:1.17-slim

ENV MIX_ENV="prod"

RUN apt-get update -y && apt-get install -y build-essential git sqlite3 npm 
RUN apt-get install -y curl
RUN npm install npm@latest -g && \
    npm install n -g && \
    n latest

WORKDIR /app

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
COPY priv priv
COPY lib lib
COPY assets assets
COPY rel rel

RUN touch .

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

RUN ( cd assets && npm install ) 
RUN mix assets.deploy
RUN mix compile

RUN sqlite3 board_prod.db < priv/repo/seeds/board-meetings.sql
RUN touch .

CMD ["mix", "phx.server"]

