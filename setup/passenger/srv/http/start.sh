#!/bin/sh
exec bundle exec passenger start \
  --port 80 \
  --max-pool-size 8 \
  --min-instances 8 \
  --environment production \
  --disable-anonymous-telemetry \
  --no-turbo-caching \
  --log-file /dev/stdout
