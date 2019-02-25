
namespace :falcon do
	task :base do
		sh "mkdir -p falcon"
		sh "sudo pacstrap -c falcon base base-devel postgresql git ruby ruby-rake ruby-bundler"
	end
	
	task :setup do
		sh "sudo cp -r setup/base/* falcon/"
		sh "sudo cp -r setup/falcon/* falcon/"

		sh "sudo arch-chroot falcon rake setup"
	end
	
	task :run do
		sh "sudo systemd-nspawn --network-veth --boot -D falcon"
	end
end

namespace :passenger do
	task :base do
		sh "mkdir -p passenger"
		sh "sudo pacstrap -c passenger base base-devel postgresql git ruby ruby-rake ruby-bundler nginx nginx-mod-passenger"
	end
	
	task :setup do
		sh "sudo cp -r setup/base/* passenger/"
		sh "sudo cp -r setup/passenger/* passenger/"

		sh "sudo arch-chroot passenger rake setup"
	end
	
	task :run do
		sh "sudo systemd-nspawn --network-veth --boot -D passenger"
	end
end

namespace :benchmark do
	task :small do
		sh "plotty -n small -x '1:*2:512' -y 'Rate: (\\d+\\.\\d+)req/s; Latency: (\\d+\\.\\d+)ms' -e 'set terminal svg size 800, 600 enhanced; set key left above' -- 'wrk -s output.lua -c $x -t $x -d 1 http://falcon/small' 'wrk -s output.lua -c $x -t $x -d 1 http://passenger/small' > small.svg"
	end
	
	task :large do
		sh "plotty -n large -x '1:*2:512' -y 'Rate: (\\d+\\.\\d+)req/s; Latency: (\\d+\\.\\d+)ms' -e 'set terminal svg size 800, 600 enhanced; set key left above' -- 'wrk -s output.lua -c $x -t $x -d 1 http://falcon/large' 'wrk -s output.lua -c $x -t $x -d 1 http://passenger/large' > large.svg"
	end
	
	task :sleep do
		sh "plotty -n sleep -x '1:*2:1024' -y 'Rate: (\\d+\\.\\d+)req/s; Latency: (\\d+\\.\\d+)ms; Errors: (\\d+\\.\\d+)req/s' -e 'set terminal svg size 800, 600 enhanced; set key left above' -- 'wrk -s output.lua -c $x -t $x -d 1 http://falcon/sleep' 'wrk -s output.lua -c $x -t $x -d 1 http://passenger/sleep' > sleep.svg"
	end
end
