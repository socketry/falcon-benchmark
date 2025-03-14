
prepend Actions

require "falcon/benchmark/data"
require "falcon/benchmark/field"

on '*' do |request, path|
	@data = Falcon::Benchmark::Data.all
	@name = path.components.last || 'small'
	
	# {"concurrency":1,"total":99,"duration":1099907,"errors":0,"latency":0.011044,"histogram":{"50.000000":10177.0,"75.000000":10201.0,"90.000000":10231.0,"95.000000":10330.0,"99.000000":10432.0,"99.900000":10432.0}}
	@fields = [
		Falcon::Benchmark::Field.new(:requests, "Request/s", :rate) {|result| result[:total] / result[:duration]},
		Falcon::Benchmark::Field.new(:latency, "Latency", :duration) {|result| result[:latency]},
		Falcon::Benchmark::Field.new(:errors, "Errors/s", :rate) {|result| result[:errors] / result[:duration]},
	]
	
	path.components = ["index"]
end