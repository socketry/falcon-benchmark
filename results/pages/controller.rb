
prepend Actions

require "falcon/benchmark/data"
require "falcon/benchmark/field"

on '*' do |request, path|
	@data = Falcon::Benchmark::Data.all
	@name = path.components.last || 'small'
	
	@fields = [
		Falcon::Benchmark::Field.new(:requests, "Request/s", :rate) {|result| result[:total].to_f / result[:duration] * 1_000_000},
		Falcon::Benchmark::Field.new(:latency, "Latency", :duration) {|result| result[:latency] * 1_000_000},
		Falcon::Benchmark::Field.new(:errors, "Errors/s", :rate) {|result| result[:errors].to_f / result[:duration] * 1_000_000},
	]
	
	path.components = ["index"]
end