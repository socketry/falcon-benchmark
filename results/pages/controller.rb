
prepend Actions

require "falcon/benchmark/data"

on 'index' do |request, path|
	@data = Falcon::Benchmark::Data.all
end