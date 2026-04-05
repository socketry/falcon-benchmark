require "uri"

SERVERS = [
	"http://falcon",
	"http://puma",
	"http://unicorn",
	"http://pitchfork",
	"http://passenger",
]

BENCHMARKS = [
	"/small",
	"/large",
	"/blocking",
	"/nonblocking",
]

CONCURRENCY = 10.times.map{|i| 2**i}

# Run the benchmark suite for all servers and write results
#
# @parameter output [String] The output root directory.
def all(output: "data/")
	SERVERS.each do |server|
		benchmark(server, output: output)
		
		Console.info(self, "Waiting for sockets to drain...", server: server)
		sleep(20)
	end
end

# Run the benchmark suite for a single server and write results
#
# @parameter server [String] The server URL to benchmark.
# @parameter output [String] The output root directory.
def benchmark(server, output: "data/")
	BENCHMARKS.each do |benchmark|
		url = URI.parse(server) + benchmark
		
		results = benchmark_server(url)
		file_name = "#{url.host}-#{url.scheme}#{url.path.gsub("/", "-")}.json"
		output_file = File.join(output, file_name)
		File.open(output_file, "w") do |file|
			JSON.dump(results, file)
		end
	end
end

private

def benchmark_server(url)
	results = []
	
	Console.info(self, "Warmup...", url: url)
	
	warmup_server(url)
	
	Console.info(self, "Benchmarking...", url: url)
	
	CONCURRENCY.each do |concurrency|
		threads = [concurrency, 8].min
		
		# Warmup at this concurrency level:
		IO.pipe do |input, output|
			Console.info(self, "Warmup...", concurrency: concurrency, url: url)
			pid = Process.spawn("wrk", "--timeout", "10", "-s", "output.lua", "-c", concurrency.to_s, "-t", threads.to_s, "-d", "1", url.to_s, out: output)
			output.close
			input.read
			Process.wait(pid)
		end
		
		IO.pipe do |input, output|
			Console.info(self, "Benchmarking...", concurrency: concurrency, url: url)
			pid = Process.spawn("wrk", "--timeout", "10", "-s", "output.lua", "-c", concurrency.to_s, "-t", threads.to_s, "-d", "6", url, out: output)
			
			output.close
			
			input.each_line do |line|
				if line.start_with?("{")
					result = JSON.parse(line)
					Console.info(self, "Result...", concurrency: concurrency, url: url, result: result)
					results << result
				else
					$stderr.puts line
				end
			end
			
			Process.wait(pid)
		end
	end
	
	return results
end

def warmup_server(url)
	require "benchmark/http/command/wait"

	Async do |task|
		task.with_timeout(30) do
			wait = Benchmark::HTTP::Command::Wait[url]
			wait.call
		end
	end
end
