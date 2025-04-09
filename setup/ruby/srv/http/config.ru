#!/usr/bin/env falcon --verbose serve -c

class Benchmark
	def initialize(app)
		@app = app
	end
	
	def empty(env)
		[204, {}, []]
	end
	
	PATH_INFO = 'PATH_INFO'.freeze
	
	def hello(env)
		[200, {}, ["Hello World!"]]
	end
	
	SMALL_BODY = ["Hello World\n" * 10] * 10
	
	def blocking(env)
		Kernel::sleep(0.01)
		
		[200, {}, SMALL_BODY]
	end
	
	def nonblocking(env)
		if defined? Async
			Async::Task.current.sleep(0.01)
		else
			Kernel::sleep(0.01)
		end
		
		[200, {}, SMALL_BODY]
	end
	
	def small(env)
		[200, {}, SMALL_BODY]
	end
	
	LARGE_BODY = ["Hello World\n" * 100] * 100
	
	def large(env)
		[200, {}, LARGE_BODY]
	end
	
	def call(env)
		_, name, *path = env[PATH_INFO].split("/")
		
		method = name&.to_sym
		
		if method and self.respond_to?(method)
			self.send(method, env)
		else
			@app.call(env)
		end
	end
end

use Benchmark

run lambda{|env|
	[200, {}, ["Hello World!"]]
}
