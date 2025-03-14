module Falcon
	module Benchmark
		class Field
			def initialize(name, label, type, &block)
				@name = name
				@label = label
				@type = type
				@block = block
			end
			
			attr :name
			attr :label
			attr :type
			
			def value(result)
				@block.call(result)
			end
		end
	end
end
