require "json"

module Falcon
	module Benchmark
		class Data
			ROOT = File.join(__dir__, "../../../data")
			
			def self.all(root = ROOT)
				data = self.new
				
				Dir.glob("*.json", base: root).map do |file|
					name = file.gsub(".json", "").split("-")
					benchmark = JSON.load_file(File.join(root, file), symbolize_names: true)
					
					data.assign(name, benchmark[:results])
				end
				
				return data
			end
			
			def initialize(dimensions = [])
				@dimensions = dimensions
			end
			
			def filters(index)
				@dimensions.map do |name, _|
					name.each_with_index.map do |value, i|
						i == index ? value : "*"
					end
				end.sort.uniq
			end
			
			def select(filter)
				dimensions = @dimensions.select do |name, _|
					filter.each_with_index.all? do |value, index|
						value.nil? || name[index] == value
					end
				end
				
				return self.class.new(dimensions)
			end
			
			def assign(name, results)
				@dimensions << [name, results]
			end
			
			def labels
				@dimensions.map do |name, _|
					name.join("-")
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

