require "json"

module Falcon
	module Benchmark
		class Data
			ROOT = File.join(__dir__, "../../../data")
			
			def self.all(root = ROOT)
				data = self.new
				
				Dir.glob("*-*-large.json", base: root).map do |file|
					name = file.gsub(".json", "").split("-")
					benchmark = JSON.load_file(File.join(root, file), symbolize_names: true)
					
					data.assign(name, benchmark[:results])
				end
				
				return data
			end
			
			def initialize(label = 0, benchmark = -1)
				@label = label
				@benchmark = benchmark
				@dimensions = []
			end
			
			def assign(name, results)
				@dimensions << [name, results]
			end
			
			def labels
				@dimensions.map do |name, _|
					name[@label]
				end
			end
			
			def each
				return to_enum unless block_given?
				
				@dimensions.map do |name, results|
					yield name, results
				end
			end
		end
	end
end

