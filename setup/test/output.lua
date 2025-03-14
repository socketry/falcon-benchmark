done = function(summary, latency, requests)
	-- Total number of connections:
	local concurrency = summary.connections
	local total = summary.requests - summary.errors.status
	local duration = summary.duration
	
	local success_rate = total / duration
	local error_total = summary.errors.total
	local error_rate = error_total / duration
	
	local connections_per_thread = summary.connections / summary.threads
	local effective_latency = (1.0 / requests.mean) * connections_per_thread
	
	local percentiles = {50, 75, 90, 95, 99, 99.9}
	
	local histogram = "{"
	
	for _, p in ipairs(percentiles) do
		local value = latency:percentile(p)
		histogram = histogram .. string.format("\"%f\":%f,", p, value)
	end
	
	histogram = histogram:sub(1, -2) .. "}"
	
	io.write(string.format(
		"{\"concurrency\":%d,\"total\":%d,\"duration\":%d,\"errors\":%d,\"latency\":%f,\"histogram\":%s}\n",
		concurrency,
		total,
		duration,
		error_total,
		effective_latency,
		histogram
	))
end
