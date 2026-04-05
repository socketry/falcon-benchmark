# Falcon vs Puma vs Unicorn

A synthetic benchmark comparing [Falcon](https://github.com/socketry/falcon), [Puma](https://github.com/puma/puma), and [Unicorn](https://yhbt.net/unicorn/) across four request profiles: small response, large response, non-blocking sleep, and blocking sleep.

## Results

Interactive charts are published at: <https://socketry.github.io/falcon-benchmark/>

## Usage

The benchmark runs inside Docker containers. You will need Docker with the Compose plugin installed.

Build the containers:

	bake build

Run the full benchmark suite (results are written to `results/data/`):

	bake benchmark

Tear down containers when done:

	bake clean

### Latency Calculations

By default `wrk` computes latency as the time from sending the first byte to when the response is received completely. This does not account for time the server spent waiting to `accept` the connection, which is significant under high contention.

This benchmark uses [a fork of wrk](https://github.com/ioquatix/wrk) that captures per-request latency more accurately.
