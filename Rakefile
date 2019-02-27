
load File.expand_path('benchmark/benchmark.rake', __dir__)

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

namespace :puma do
	task :base do
		sh "mkdir -p puma"
		sh "sudo pacstrap -c puma base base-devel postgresql git ruby ruby-rake ruby-bundler"
	end
	
	task :setup do
		sh "sudo cp -r setup/base/* puma/"
		sh "sudo cp -r setup/puma/* puma/"

		sh "sudo arch-chroot puma rake setup"
	end
	
	task :run do
		sh "sudo systemd-nspawn --network-veth --boot -D puma"
	end
end

namespace :passenger_standalone do
	task :base do
		sh "mkdir -p passenger-standalone"
		sh "sudo pacstrap -c passenger-standalone base base-devel postgresql git ruby ruby-rake ruby-bundler passenger"
	end
	
	task :setup do
		sh "sudo cp -r setup/base/* passenger-standalone/"
		sh "sudo cp -r setup/passenger-standalone/* passenger-standalone/"

		sh "sudo arch-chroot passenger-standalone rake setup"
	end
	
	task :run do
		sh "sudo systemd-nspawn --network-veth --boot -D passenger-standalone"
	end
end
