
prepend Actions

require "falcon/benchmark/data"
require "falcon/benchmark/field"

on '**' do |request, path|
	@data = Falcon::Benchmark::Data.all
	if path.components.any?
		filter = path.components.map{|component| component == "*" ? nil : component}
		@data = @data.select(filter)
	end
	
	@fields = [
		Falcon::Benchmark::Field.new(:requests, "Request/s", :rate) {|result| result[:requests].to_f / result[:duration] * 1_000_000},
		Falcon::Benchmark::Field.new(:latency, "Latency", :duration) {|result| result[:latency][:mean] / 1_000_000},
		Falcon::Benchmark::Field.new(:errors, "Errors/s", :rate) {|result| result[:errors].to_f / result[:duration] * 1_000_000},
	]
	
	path.components = ["index"]
end