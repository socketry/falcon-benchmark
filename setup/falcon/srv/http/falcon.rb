require "falcon/environment/rack"
require_relative "limited"

service "falcon.localhost" do
	include Falcon::Environment::Rack
	
	count 8
	
	scheme "http"
	protocol {Async::HTTP::Protocol::HTTP1.new(persistent: false)}
	
	endpoint_options do
		super().merge(
			protocol: protocol,
			# wrapper: Limited::Wrapper.new
		)
	end
	
	url "http://0.0.0.0"
	
	endpoint do
		::Async::HTTP::Endpoint.parse(url).with(**endpoint_options)
	end
end
