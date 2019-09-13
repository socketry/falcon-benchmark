
require 'irb'

load File.expand_path('benchmark/benchmark.rake', __dir__)

INSTANCES = {
	falcon: 'falcon',
	passenger: 'passenger',
	passenger_standalone: 'passenger-standalone',
	puma: 'puma',
	unicorn: 'unicorn',
}

BASE = %w{base base-devel postgresql git ruby ruby-rake ruby-bundler}

PACKAGES = {
	passenger: %w{nginx nginx-mod-passenger},
	passenger_standalone: %w{passenger}
}

task :clean do
	INSTANCES.each do |name, path|
		if task = task.application.lookup(:"#{name}:stop")
			task.invoke
		end
		
		FileUtils::Dry.rm_rf(path)
	end
end

INSTANCES.each do |name, path|
	namespace name do
		task :root do
			FileUtils.mkdir_p path
		end
		
		task :base => :root do
			sh "sudo", "pacstrap", "-c", path, *BASE, *PACKAGES[name]
		end
		
		task :setup => :base do
			sh "sudo cp -r setup/base/* #{path}/"
			sh "sudo cp -r setup/#{path}/* #{path}/"

			sh "sudo arch-chroot #{path} rake setup"
		end
		
		task :stop do
			sh "sudo", "machinectl", "stop", path.to_s
			sh "sudo", "tmux", "kill-session", "-t", name.to_s
		rescue
			# Ignore
		end
		
		task :start do
			sh "sudo", "tmux", "new-session", "-d", "-s", name.to_s, "systemd-nspawn --network-veth --boot -D #{path}"
		rescue
			# Ignore
		end
		
		task :attach do
			sh "sudo", "tmux", "attach", "-t", name.to_s
		end
		
		task :shell do
			sh "sudo", "machinectl", "shell", path.to_s
		end
		
		task :test do
			sh "curl", "--output", "/dev/null", "http://#{path}/small"
		end
	end
end

task :setup do
	INSTANCES.each do |name, path|
		task.application[:"#{name}:setup"].invoke
	end
end

task :stop do
	INSTANCES.each do |name, path|
		task.application[:"#{name}:stop"].invoke
	end
end

task :start do
	INSTANCES.each do |name, path|
		task.application[:"#{name}:start"].invoke
	end
end

task :test do
	INSTANCES.each do |name, path|
		task.application[:"#{name}:test"].invoke
	end
end
