
namespace :benchmark do
	PLOTTY = "plotty"
	PATTERN = 'Rate: (\d+\.\d+)req/s; Latency: (\d+\.\d+)ms; Errors: (\d+\.\d+)req/s'
	
	X512 = '1,2,4,8,16,32,64,96,128,160,192,224,256,288,320,352,384,416,448,480,512'
	X1024 = '1,2,4,8,16,32,64,96,128,160,192,224,256,288,320,352,384,416,448,480,512,544,576,608,640,672,704,736,768,800,832,864,896,928,960,992,1024'
	
	HOSTS = [
		"http://falcon",
		"http://passenger",
		"http://passenger-standalone",
		"http://puma",
	]
	
	def wrk(url)
		"wrk -s output.lua -c $x -t $x -d 1 #{url}"
	end
	
	def commands_for(name)
		commands = HOSTS.map{|base| wrk(base + "/#{name}")}
		output = File.expand_path("#{name}.svg", __dir__)
		
		yield name, commands, output
	end
	
	task :small do
		commands_for("small") do |name, commands, output|
			sh "plotty", "-n", name, "-x", X512, "-y", PATTERN, "--", *commands, chdir: __dir__, out: output
		end
	end
	
	task :large do
		commands_for("large") do |name, commands, output|
			sh "plotty", "-n", name, "-x", X512, "-y", PATTERN, "--", *commands, chdir: __dir__, out: output
		end
	end
	
	task :blocking do
		commands_for("blocking") do |name, commands, output|
			sh "plotty", "-n", name, "-x", X512, "-y", PATTERN, "--", *commands, chdir: __dir__, out: output
		end
	end
	
	task :nonblocking do
		commands_for("nonblocking") do |name, commands, output|
			sh "plotty", "-n", name, "-x", X512, "-y", PATTERN, "--", *commands, chdir: __dir__, out: output
		end
	end
	
	task :all => [:small, :large, :blocking, :nonblocking]
end
