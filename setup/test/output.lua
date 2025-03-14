-- function done(summary, latency, requests)

--   The done() function receives a table containing result data, and two
--   statistics objects representing the per-request latency and per-thread
--   request rate. Duration and latency are microsecond values and rate is
--   measured in requests per second.

--   latency.min              -- minimum value seen
--   latency.max              -- maximum value seen
--   latency.mean             -- average value seen
--   latency.stdev            -- standard deviation
--   latency:percentile(99.0) -- 99th percentile value
--   latency(i)               -- raw value and count

--   summary = {
--     duration = N,  -- run duration in microseconds
--     requests = N,  -- total completed requests
--     bytes    = N,  -- total bytes received
--     errors   = {
--       connect = N, -- total socket connection errors
--       read    = N, -- total socket read errors
--       write   = N, -- total socket write errors
--       status  = N, -- total HTTP status codes > 399
--       timeout = N  -- total request timeouts
--     }
--   }

done = function(summary, latency, requests)
	-- Total number of connections:
	local concurrency = summary.connections
	local duration = summary.duration
	local requests = summary.requests
	local errors = summary.errors.connect + summary.errors.read + summary.errors.write + summary.errors.status + summary.errors.timeout	
	
	local percentiles = {50, 75, 90, 95, 99, 100}
	
	local latency_json = string.format(
		"{\"min\":%f,\"max\":%f,\"mean\":%f,\"stdev\":%f,\"percentile\":{",
		latency.min,
		latency.max,
		latency.mean,
		latency.stdev
	)
	
	for _, p in ipairs(percentiles) do
		local value = latency:percentile(p)
		latency_json = latency_json .. string.format("\"%d\":%f,", p, value)
	end
	
	latency_json = latency_json:sub(1, -2) .. "}}"
	
	io.write(string.format(
		"{\"concurrency\":%d,\"duration\":%d,\"requests\":%d,\"errors\":%d,\"latency\":%s}\n",
		concurrency,
		duration,
		requests,
		errors,
		latency_json
	))
end
