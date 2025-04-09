require "uri"

SERVERS = [
	"http://falcon",
	"http://puma",
	"http://unicorn",
]

BENCHMARKS = [
	"/small",
	"/large",
	"/blocking",
	"/nonblocking",
]

CONCURRENCY = 10.times.map{|i| 2**i}

# @parameter output [String] The output root directory.
def all(output:)
	SERVERS.each do |server|
		BENCHMARKS.each do |benchmark|
			url = URI.parse(server) + benchmark
			
			results = benchmark(url)
			file_name = "#{url.host}-#{url.scheme}#{url.path.gsub("/", "-")}.json"
			output_file = File.join(output, file_name)
			File.open(output_file, "w") do |file|
				JSON.dump(results, file)
			end
		end
	end
end

private

def benchmark(url)
	results = []
	
	Console.info(self, "Warmup...", url: url)
	
	warmup(url)
	
	Console.info(self, "Benchmarking...", url: url)
	
	CONCURRENCY.each do |concurrency|
		IO.pipe do |input, output|
			threads = [concurrency, 8].min
			
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

def warmup(url)
	require "benchmark/http/command/wait"
	
	wait = Benchmark::HTTP::Command::Wait[url]
	
	wait.call
end
