FROM ruby:latest AS base
WORKDIR /app
RUN git clone https://github.com/ioquatix/wrk && cd wrk && make
RUN cp wrk/wrk /usr/local/bin/wrk

FROM base AS bundled
WORKDIR /app
COPY setup/test/ /app
RUN bundle install

FROM bundled AS benchmark
WORKDIR /app
CMD ["bundle", "exec", "bake", "benchmark:all", "--output", "/app/data"]
