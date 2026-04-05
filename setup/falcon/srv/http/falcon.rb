require "falcon/environment/rack"

service "falcon.localhost" do
	include Falcon::Environment::Rack
	
	count 8
	
	url "http://0.0.0.0"
	
	endpoint do
		::Async::HTTP::Endpoint.parse(url)
	end
end
