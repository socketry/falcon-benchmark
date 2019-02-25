-- example reporting script which demonstrates a custom
-- done() function that prints latency percentiles as CSV

done = function(summary, latency, requests)
	total = summary.requests - summary.errors.status
	success_rate = total / summary.duration
	error_rate = summary.errors.status / summary.duration
	io.write(string.format(
		"Rate: %0.3freq/s; Latency: %0.3fms; Errors: %0.3freq/s\n",
		success_rate * 1000000.0,
		latency.mean / 1000.0,
		error_rate * 1000000.0
	))
end